import 'dart:typed_data';
import 'package:uuid/uuid.dart';

import 'package:travel/core/exceptions/app_exception.dart';
import 'package:travel/data/datasources/local_storage_service.dart';
import 'package:travel/data/datasources/stable_diffusion_api_service.dart';
import 'package:travel/domain/entities/destination_image_entity.dart';
import 'package:travel/domain/repositories/destination_image_repository.dart';

/// Implementación del repositorio para manejo de imágenes de destinos
class DestinationImageRepositoryImpl extends DestinationImageRepository {
  final StableDiffusionApiService _apiService;
  final LocalStorageService _storageService;
  final Uuid _uuid = const Uuid();

  /// Constructor del repositorio
  DestinationImageRepositoryImpl({
    required StableDiffusionApiService apiService,
    required LocalStorageService storageService,
  })  : _apiService = apiService,
        _storageService = storageService;

  @override
  Future<DestinationImageEntity> generateDestinationImage(
    String destination, {
    String? additionalPromptContext,
    int retryCount = 3,
  }) async {
    int attempts = 0;
    late AppException lastException;

    while (attempts < retryCount) {
      try {
        attempts++;

        // Generar un prompt mejorado para la imagen
        final prompt = _apiService.generateEnhancedPrompt(
          destination,
          context: additionalPromptContext,
        );

        // Generar la imagen a través de la API
        final Uint8List imageData = await _apiService.generateImage(
          prompt: prompt,
          width: 1024,
          height: 768,
        );

        // Guardar la imagen en almacenamiento local
        final String localPath = await _storageService.saveImage(
          imageData,
          destination,
        );

        // Crear y retornar la entidad con la información de la imagen
        return DestinationImageEntity(
          id: UuidValue.fromString(_uuid.v4()),
          destination: destination,
          localPath: localPath,
          prompt: prompt,
          generatedAt: DateTime.now(),
          status: ImageGenerationStatus.success,
        );
      } catch (e) {
        lastException = e is AppException
            ? e
            : AppException(
                message: 'Error inesperado al generar imagen',
                code: 'UNEXPECTED_ERROR',
                error: e.toString(),
              );

        // Si no es el último intento, esperar antes de reintentar
        if (attempts < retryCount) {
          // Espera exponencial: 1s, 2s, 4s...
          final waitTime = Duration(seconds: 1 << (attempts - 1));
          await Future.delayed(waitTime);
        }
      }
    }

    // Si llegamos aquí, todos los intentos fallaron
    throw AppException(
      message: 'No se pudo generar la imagen después de $retryCount intentos',
      code: 'MAX_RETRIES_EXCEEDED',
      error: lastException.toString(),
    );
  }

  @override
  Future<String> saveImageToLocalStorage(
    Uint8List imageData,
    String destination,
  ) async {
    return _storageService.saveImage(imageData, destination);
  }

  @override
  Future<DestinationImageEntity?> getDestinationImage(
      String destination) async {
    // En una implementación real, aquí consultaríamos una base de datos local
    // para obtener la información de la imagen asociada al destino
    // Por ahora, retornamos null para indicar que no hay imagen generada
    return null;
  }

  @override
  Future<bool> deleteDestinationImage(UuidValue imageId) async {
    // En una implementación real, aquí buscaríamos la entidad por su ID
    // y luego usaríamos _storageService.deleteImage con la ruta localPath
    // Por ahora, retornamos false para indicar que no se pudo eliminar
    return false;
  }
}
