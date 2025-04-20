import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/datasources/ai_text_generator_datasource.dart';
import '../../../data/providers/ai_provider.dart';

// Estado del itinerario
class ItineraryState {
  final bool isLoading;
  final String? itinerary;
  final String? error;

  const ItineraryState({this.isLoading = false, this.itinerary, this.error});

  ItineraryState copyWith({bool? isLoading, String? itinerary, String? error}) {
    return ItineraryState(
      isLoading: isLoading ?? this.isLoading,
      itinerary: itinerary ?? this.itinerary,
      error: error ?? this.error,
    );
  }
}

// Notificador para manejar la generación del itinerario
class ItineraryNotifier extends StateNotifier<ItineraryState> {
  final AiTextGeneratorDatasource _aiTextGeneratorDatasource;

  ItineraryNotifier(this._aiTextGeneratorDatasource)
    : super(const ItineraryState());

  // Convierte texto markdown a texto plano
  String _formatMarkdownToPlainText(String markdown) {
    // Elimina los encabezados (#)
    var text = markdown.replaceAll(RegExp(r'#{1,6}\s'), '');

    // Elimina los asteriscos para negritas/cursivas
    text = text.replaceAll(RegExp(r'\*{1,2}'), '');

    // Elimina los guiones bajos para negritas/cursivas
    text = text.replaceAll(RegExp(r'_{1,2}'), '');

    // Convierte listas con guiones a texto con viñetas
    text = text.replaceAll(RegExp(r'^\s*-\s'), '• ');

    // Remueve los enlaces dejando solo el texto
    text = text.replaceAll(RegExp(r'\[([^\]]+)\]\([^\)]+\)'), r'$1');

    // Elimina los bloques de código
    text = text.replaceAll(RegExp(r'`{1,3}[^`]*`{1,3}'), '');

    // Normaliza los saltos de línea
    text = text.replaceAll(RegExp(r'\n{3,}'), '\n\n');

    return text.trim();
  }

  Future<void> generateItinerary(
    String destination, {
    required int days,
    String language = 'es',
    List<String>? interests,
    String? budget,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final markdownItinerary = await _aiTextGeneratorDatasource
          .generateTripItinerary(
            destination,
            days: days,
            language: language,
            interests: interests,
            budget: budget,
          );

      final plainTextItinerary = _formatMarkdownToPlainText(markdownItinerary);
      state = state.copyWith(isLoading: false, itinerary: plainTextItinerary);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

// Provider para el generador de itinerarios
final itineraryProvider =
    StateNotifierProvider<ItineraryNotifier, ItineraryState>((ref) {
      final aiGenerator = ref.watch(aiTextGeneratorProvider);
      return ItineraryNotifier(aiGenerator);
    });
