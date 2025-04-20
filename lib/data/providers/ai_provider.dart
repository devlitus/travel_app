import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../../core/config/environment_config.dart';
import '../datasources/ai_text_generator_datasource.dart';

// Provider para el modelo de Gemini
final geminiModelProvider = Provider<GenerativeModel>((ref) {
  final apiKey = EnvironmentConfig.apiKey;
  return GenerativeModel(model: 'gemini-2.0-flash', apiKey: apiKey);
});

// Provider para el generador de texto AI
final aiTextGeneratorProvider = Provider<AiTextGeneratorDatasource>((ref) {
  final model = ref.watch(geminiModelProvider);
  return AiTextGeneratorDatasource(model);
});
