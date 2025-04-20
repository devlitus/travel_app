import '../../domain/repositories/ai_repository.dart';
import '../datasources/ai_text_generator_datasource.dart';

/// Implementación del repositorio de IA
class AiRepositoryImpl implements AiRepository {
  final AiTextGeneratorDatasource _aiTextGeneratorDatasource;

  /// Constructor para la implementación del repositorio de IA
  const AiRepositoryImpl(this._aiTextGeneratorDatasource);

  @override
  Future<String> generateTripItinerary(
    String destination, {
    required int days,
    String language = 'es',
    List<String>? interests,
    String? budget,
    String? systemPrompt,
  }) async {
    return _aiTextGeneratorDatasource.generateTripItinerary(
      destination,
      days: days,
      language: language,
      interests: interests,
      budget: budget,
      systemPrompt: systemPrompt,
    );
  }
}
