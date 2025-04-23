import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import 'package:travel/core/exceptions/app_exception.dart';

/// Servicio para el almacenamiento local de imágenes generadas
class LocalStorageService {
  static const String _imagesDirectoryName = 'destination_images';
  final Uuid _uuid = const Uuid();

  /// Guarda una imagen en el almacenamiento local del dispositivo
  ///
  /// [imageData] son los bytes de la imagen a guardar
  /// [destination] es el nombre del destino asociado a la imagen
  ///
  /// Devuelve la ruta local donde se guardó la imagen
  Future<String> saveImage(Uint8List imageData, String destination) async {
    try {
      final directory = await _getImagesDirectory();

      // Generar un nombre de archivo único basado en el destino
      final String safeDestinationName = _getSafeFileName(destination);
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String uniqueId = _uuid.v4().substring(0, 8);
      final String fileName =
          '${safeDestinationName}_${timestamp}_$uniqueId.png';

      final String filePath = '${directory.path}/$fileName';

      final File file = File(filePath);
      await file.writeAsBytes(imageData);

      return filePath;
    } catch (e) {
      throw AppException(
        message: 'Error al guardar la imagen localmente',
        code: 'LOCAL_STORAGE_ERROR',
        error: e.toString(),
      );
    }
  }

  /// Elimina una imagen del almacenamiento local
  ///
  /// [filePath] es la ruta completa del archivo a eliminar
  ///
  /// Devuelve true si la eliminación fue exitosa, false en caso contrario
  Future<bool> deleteImage(String filePath) async {
    try {
      final File file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e) {
      throw AppException(
        message: 'Error al eliminar la imagen',
        code: 'DELETE_IMAGE_ERROR',
        error: e.toString(),
      );
    }
  }

  /// Obtiene la ruta del directorio de imágenes, creándolo si no existe
  Future<Directory> _getImagesDirectory() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final Directory imagesDir =
        Directory('${appDir.path}/$_imagesDirectoryName');

    if (!await imagesDir.exists()) {
      await imagesDir.create(recursive: true);
    }

    return imagesDir;
  }

  /// Convierte un nombre de destino en un nombre de archivo seguro
  String _getSafeFileName(String destination) {
    // Reemplazar caracteres no válidos para nombres de archivo
    return destination
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '_');
  }
}
