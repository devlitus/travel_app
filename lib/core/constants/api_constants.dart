/// Constantes para las APIs utilizadas en la aplicación
class ApiConstants {
  // Constantes generales
  static const String baseUrl = 'https://api.example.com';

  // Constantes para Stable Diffusion API
  static const String stableDiffusionApiUrl =
      'https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image';

  // Nunca almacenar API keys directamente en el código en producción
  // Esto es solo para desarrollo, en producción usar variables de entorno
  // o almacenamiento seguro
  static const String stableDiffusionApiKey = 'TU_API_KEY_AQUI';
}
