import 'package:uuid/uuid.dart';

/// Entidad que representa una imagen generada por IA para un destino de viaje
class DestinationImageEntity {
  /// Identificador único de la imagen en formato UUID
  final UuidValue id;

  /// Destino al que pertenece la imagen
  final String destination;

  /// Ruta local del archivo de imagen
  final String localPath;

  /// Prompt utilizado para generar la imagen
  final String prompt;

  /// Fecha de generación de la imagen
  final DateTime generatedAt;

  /// Estado de la generación (éxito, error, etc.)
  final ImageGenerationStatus status;

  /// Constructor para la entidad de imagen de destino
  const DestinationImageEntity({
    required this.id,
    required this.destination,
    required this.localPath,
    required this.prompt,
    required this.generatedAt,
    this.status = ImageGenerationStatus.success,
  });

  /// Crea una copia de la entidad con campos opcionales modificados
  DestinationImageEntity copyWith({
    UuidValue? id,
    String? destination,
    String? localPath,
    String? prompt,
    DateTime? generatedAt,
    ImageGenerationStatus? status,
  }) {
    return DestinationImageEntity(
      id: id ?? this.id,
      destination: destination ?? this.destination,
      localPath: localPath ?? this.localPath,
      prompt: prompt ?? this.prompt,
      generatedAt: generatedAt ?? this.generatedAt,
      status: status ?? this.status,
    );
  }
}

/// Enumeración para representar el estado de generación de una imagen
enum ImageGenerationStatus {
  /// Imagen generada exitosamente
  success,

  /// Error durante la generación
  error,

  /// Generación en progreso
  inProgress,

  /// Generación no iniciada
  pending
}
