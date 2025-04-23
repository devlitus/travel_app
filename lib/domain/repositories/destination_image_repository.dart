import 'dart:typed_data';
import 'package:uuid/uuid.dart';

import 'package:travel/domain/entities/destination_image_entity.dart';
import 'package:travel/core/exceptions/app_exception.dart';
import 'package:travel/domain/repositories/base_repository.dart';

/// Repositorio para manejo de imágenes de destinos generadas con IA
abstract class DestinationImageRepository extends BaseRepository {
  /// Genera una imagen para un destino específico
  ///
  /// [destination] es el nombre del destino para el que se generará la imagen
  /// [additionalPromptContext] es información adicional para enriquecer el prompt
  /// [retryCount] número máximo de reintentos en caso de fallo
  ///
  /// Devuelve una entidad [DestinationImageEntity] con la información de la imagen generada
  /// o lanza un [AppException] si la generación falla después de todos los reintentos
  Future<DestinationImageEntity> generateDestinationImage(
    String destination, {
    String? additionalPromptContext,
    int retryCount = 3,
  });

  /// Guarda una imagen en almacenamiento local
  ///
  /// [imageData] son los bytes de la imagen a guardar
  /// [destination] es el nombre del destino asociado a la imagen
  ///
  /// Devuelve la ruta local donde se guardó la imagen
  Future<String> saveImageToLocalStorage(
      Uint8List imageData, String destination);

  /// Obtiene una imagen para un destino específico
  ///
  /// [destination] es el nombre del destino cuya imagen se quiere obtener
  ///
  /// Devuelve la entidad [DestinationImageEntity] si existe,
  /// o null si no hay imagen generada para ese destino
  Future<DestinationImageEntity?> getDestinationImage(String destination);

  /// Elimina una imagen guardada localmente
  ///
  /// [imageId] es el identificador de la imagen a eliminar
  ///
  /// Devuelve true si la eliminación fue exitosa, false en caso contrario
  Future<bool> deleteDestinationImage(UuidValue imageId);
}
