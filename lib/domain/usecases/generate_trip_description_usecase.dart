import '../entities/trip_description_entity.dart';
import '../repositories/ai_repository.dart';

/// Caso de uso para generar descripciones de viajes usando IA
class GenerateTripDescriptionUseCase {
  final AiRepository _aiRepository;

  /// Constructor para el caso de uso de generación de descripciones
  const GenerateTripDescriptionUseCase(this._aiRepository);

  /// Ejecuta el caso de uso para generar una descripción de viaje
  ///
  /// [destination] es el destino del viaje
  /// [days] es la duración del viaje en días (default: 7)
  /// [language] es el idioma en que se generará la descripción (default: 'es')
  /// [interests] son los intereses particulares del viajero (opcional)
  /// [budget] es el presupuesto aproximado (opcional)
  Future<TripItineraryEntity> call(
    String destination, {
    int days = 7,
    String language = 'es',
    List<String>? interests,
    String? budget,
  }) async {
    final description = await _aiRepository.generateTripItinerary(
      destination,
      days: days,
      language: language,
      interests: interests,
      budget: budget,
    );

    return TripItineraryEntity(
      destination: destination,
      description: description,
      startTripDate: DateTime.now(),
      endTripDate: DateTime.now().add(Duration(days: days)),
      generatedAt: DateTime.now(),
    );
  }
}
