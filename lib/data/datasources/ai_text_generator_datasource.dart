import 'package:google_generative_ai/google_generative_ai.dart';
import '../../core/exceptions/api_exception.dart';

/// Fuente de datos para generación de texto usando IA (Gemini)
class AiTextGeneratorDatasource {
  final GenerativeModel _model;

  /// Prompt de sistema predeterminado para generación de viajes con timeline
  final String _defaultSystemPrompt = '''
  Eres un asesor de viajes experto especializado en crear itinerarios detallados y atractivos.
  Tu objetivo es proporcionar una timeline diaria de actividades para viajes de hasta 7 días.
  Para cada día debes sugerir:
  - Actividades culturales (museos, monumentos, sitios históricos)
  - Experiencias gastronómicas (restaurantes, mercados, platos típicos)
  - Actividades de ocio/naturaleza (parques, playas, senderismo)
  - Recomendaciones de transporte entre lugares
  
  Estructura la información de forma clara con el formato:
  DÍA X: [Título temático del día]
  - Mañana: [Actividades]
  - Mediodía: [Almuerzo y actividades]
  - Tarde: [Actividades]
  - Noche: [Cena y actividades nocturnas]
  
  Adapta las recomendaciones al destino específico, clima estacional y atractivos locales.
  Sé específico mencionando nombres reales de lugares, restaurantes y atracciones.
  ''';

  /// Constructor para el generador de texto basado en IA
  const AiTextGeneratorDatasource(this._model);

  /// Genera texto basado en un prompt utilizando el modelo de IA
  ///
  /// [prompt] es la solicitud o instrucción para la IA
  /// [systemPrompt] es el prompt de sistema que guía el comportamiento de la IA (opcional)
  /// Devuelve el texto generado o lanza una excepción si falla
  Future<String> generateText(String prompt, {String? systemPrompt}) async {
    try {
      final List<Content> contents = [];

      // Si hay un prompt de sistema, añadirlo primero
      if (systemPrompt != null && systemPrompt.isNotEmpty) {
        contents.add(Content.text(systemPrompt));
      }

      // Añadir el prompt del usuario
      contents.add(Content.text(prompt));

      // Generar el contenido usando el modelo
      final response = await _model.generateContent(contents);

      if (response.text == null || response.text!.isEmpty) {
        throw const ApiException('Respuesta vacía del modelo de IA');
      }

      return response.text!;
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Error al generar texto con IA', e.toString());
    }
  }

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
  }) async {
    // Validar que los días estén dentro del rango permitido
    final safeDays = days.clamp(1, 7);

    final interestsText =
        interests != null && interests.isNotEmpty
            ? 'Intereses específicos: ${interests.join(", ")}.\n'
            : '';

    final budgetText =
        budget != null ? 'Presupuesto aproximado: $budget.\n' : '';

    final prompt = '''
    Crea un itinerario detallado para un viaje a $destination con duración de $safeDays días.
    $interestsText
    $budgetText
    
    Organiza el itinerario día por día con actividades específicas para mañana, mediodía, tarde y noche.
    Incluye nombres reales de atracciones, restaurantes y lugares de interés.
    Para cada actividad, proporciona una breve descripción y tiempo estimado.
    
    Responde en $language.
    ''';

    // Usar el prompt de sistema personalizado o el predeterminado
    final finalSystemPrompt = systemPrompt ?? _defaultSystemPrompt;

    return generateText(prompt, systemPrompt: finalSystemPrompt);
  }
}
