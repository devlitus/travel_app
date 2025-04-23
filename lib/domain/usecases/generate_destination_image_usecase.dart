import 'package:travel/domain/entities/destination_image_entity.dart';
import 'package:travel/domain/repositories/destination_image_repository.dart';

/// Caso de uso para generar imágenes de destinos mediante IA
class GenerateDestinationImageUseCase {
  final DestinationImageRepository _repository;

  /// Constructor del caso de uso
  GenerateDestinationImageUseCase(this._repository);

  /// Ejecuta el caso de uso para generar una imagen del destino.
  ///
  /// [destination] es el nombre del destino para el que se generará la imagen
  /// [additionalContext] contexto adicional para enriquecer el prompt (opcional)
  /// [retryCount] número de intentos en caso de fallo (por defecto 3)
  ///
  /// Retorna una entidad [DestinationImageEntity] con la imagen generada
  Future<DestinationImageEntity> execute(
    String destination, {
    String? additionalContext,
    int retryCount = 3,
  }) {
    return _repository.generateDestinationImage(
      destination,
      additionalPromptContext: additionalContext,
      retryCount: retryCount,
    );
  }
}
