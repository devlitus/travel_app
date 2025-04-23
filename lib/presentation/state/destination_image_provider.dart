import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:travel/domain/entities/destination_image_entity.dart';
import 'package:travel/domain/usecases/generate_destination_image_usecase.dart';
import 'package:travel/data/repositories/destination_image_repository_impl.dart';
import 'package:travel/data/datasources/stable_diffusion_api_service.dart';
import 'package:travel/data/datasources/local_storage_service.dart';
import 'package:travel/core/exceptions/app_exception.dart';

/// Estados posibles para el generador de imágenes
enum ImageGenerationState {
  /// Estado inicial, sin haber generado una imagen
  initial,

  /// Generando una imagen
  loading,

  /// Generación completada exitosamente
  success,

  /// Error en la generación
  error,
}

/// Estado del provider de generación de imágenes
class DestinationImageState {
  /// Estado actual del generador
  final ImageGenerationState state;

  /// Entidad con la información de la imagen generada (si existe)
  final DestinationImageEntity? image;

  /// Mensaje de error (si hay)
  final String? errorMessage;

  /// Constructor del estado
  const DestinationImageState({
    this.state = ImageGenerationState.initial,
    this.image,
    this.errorMessage,
  });

  /// Crea una copia del estado con campos opcionales modificados
  DestinationImageState copyWith({
    ImageGenerationState? state,
    DestinationImageEntity? image,
    String? errorMessage,
  }) {
    return DestinationImageState(
      state: state ?? this.state,
      image: image ?? this.image,
      errorMessage: errorMessage,
    );
  }

  /// Estado inicial del provider
  static DestinationImageState initial() {
    return const DestinationImageState();
  }
}

/// Provider para los servicios necesarios
final stableDiffusionApiServiceProvider =
    Provider<StableDiffusionApiService>((ref) {
  return StableDiffusionApiService();
});

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return LocalStorageService();
});

/// Provider para el repositorio de imágenes
final destinationImageRepositoryProvider =
    Provider<DestinationImageRepositoryImpl>((ref) {
  final apiService = ref.watch(stableDiffusionApiServiceProvider);
  final storageService = ref.watch(localStorageServiceProvider);
  return DestinationImageRepositoryImpl(
    apiService: apiService,
    storageService: storageService,
  );
});

/// Provider para el caso de uso
final generateDestinationImageUseCaseProvider =
    Provider<GenerateDestinationImageUseCase>((ref) {
  final repository = ref.watch(destinationImageRepositoryProvider);
  return GenerateDestinationImageUseCase(repository);
});

/// StateNotifier para manejar el estado de generación de imágenes
class DestinationImageNotifier extends StateNotifier<DestinationImageState> {
  final GenerateDestinationImageUseCase _generateImageUseCase;

  /// Constructor del notificador
  DestinationImageNotifier(this._generateImageUseCase)
      : super(DestinationImageState.initial());

  /// Genera una imagen para el destino especificado
  Future<void> generateImage(
    String destination, {
    String? additionalContext,
    int retryCount = 3,
  }) async {
    // Actualizar estado a "cargando"
    state = state.copyWith(state: ImageGenerationState.loading);

    try {
      // Generar imagen con el caso de uso
      final image = await _generateImageUseCase.execute(
        destination,
        additionalContext: additionalContext,
        retryCount: retryCount,
      );

      // Actualizar estado con la imagen generada
      state = state.copyWith(
        state: ImageGenerationState.success,
        image: image,
        errorMessage: null,
      );
    } catch (e) {
      // Manejar error de generación
      final errorMessage = e is AppException
          ? e.message
          : 'Error al generar la imagen: ${e.toString()}';

      state = state.copyWith(
        state: ImageGenerationState.error,
        errorMessage: errorMessage,
      );
    }
  }

  /// Limpia el estado del generador
  void reset() {
    state = DestinationImageState.initial();
  }
}

/// Provider global para el estado de generación de imágenes
final destinationImageProvider =
    StateNotifierProvider<DestinationImageNotifier, DestinationImageState>(
        (ref) {
  final useCase = ref.watch(generateDestinationImageUseCaseProvider);
  return DestinationImageNotifier(useCase);
});
