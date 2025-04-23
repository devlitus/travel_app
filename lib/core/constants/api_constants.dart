import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Constantes para las APIs utilizadas en la aplicación
class ApiConstants {
  // Constantes generales
  static const String baseUrl = 'https://api.example.com';

  // Constantes para Stable Diffusion API
  static const String stableDiffusionApiUrl =
      'https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image';

  // Obtener API key de variables de entorno
  static String get stableDiffusionApiKey =>
      dotenv.get('STABLE_DIFFUSION_API_KEY', fallback: '');

  // Método para verificar si la API key está configurada
  static bool get isStableDiffusionConfigured =>
      stableDiffusionApiKey.isNotEmpty &&
      stableDiffusionApiKey != 'TU_API_KEY_AQUI';
}
