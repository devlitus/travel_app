import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Clase utilitaria para acceder a las variables de entorno cargadas desde .env
class EnvironmentConfig {
  /// Inicializa y carga las variables de entorno desde el archivo .env
  /// [environment] puede ser 'development', 'production', etc.
  static Future<void> initialize({String environment = ''}) async {
    String fileName = '.env.local';
    if (environment.isNotEmpty) {
      fileName = '.env.$environment';
    }

    await dotenv.load(fileName: fileName);
  }

  /// Obtiene la API key de Gemini
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  /// Verifica si la API key está configurada
  static bool get isApiKeyConfigured => apiKey.isNotEmpty;

  /// Método de utilidad para obtener cualquier variable de entorno
  static String get(String key, {String defaultValue = ''}) {
    return dotenv.env[key] ?? defaultValue;
  }
}
