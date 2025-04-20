import '../entities/trip_description_entity.dart';

/// Interfaz que define las operaciones del repositorio de IA
abstract class AiRepository {
  /// Genera un itinerario de viaje detallado con timeline de actividades
  ///
  /// [destination] es el destino del viaje
  /// [days] es la duración del viaje en días (máximo: 7)
  /// [language] es el idioma en que se generará el itinerario (default: 'es')
  /// [interests] son los intereses particulares del viajero (opcional)
  /// [budget] es el presupuesto aproximado: 'económico', 'moderado', 'lujo' (opcional)
  /// [systemPrompt] es el prompt de sistema personalizado (opcional)
  Future<String> generateTripItinerary(
    String destination, {
    required int days,
    String language = 'es',
    List<String>? interests,
    String? budget,
    String? systemPrompt,
  });
}
