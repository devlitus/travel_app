/// Entidad que representa la descripción generada para un viaje
class TripItineraryEntity {
  final String destination;
  final String description;
  final DateTime startTripDate;
  final DateTime endTripDate;
  final DateTime generatedAt;
  final String? imageUrl;

  /// Constructor para la entidad de descripción de viaje
  const TripItineraryEntity({
    required this.destination,
    required this.description,
    required this.startTripDate,
    required this.endTripDate,
    required this.generatedAt,
    this.imageUrl,
  });

  /// Crea una copia de la entidad con campos opcionales modificados
  TripItineraryEntity copyWith({
    String? destination,
    String? description,
    DateTime? generatedAt,
    DateTime? startTripDate,
    DateTime? endTripDate,
    String? imageUrl,
  }) {
    return TripItineraryEntity(
      destination: destination ?? this.destination,
      description: description ?? this.description,
      generatedAt: generatedAt ?? this.generatedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      startTripDate: startTripDate ?? this.startTripDate,
      endTripDate: endTripDate ?? this.endTripDate,
    );
  }
}
