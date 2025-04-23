/// Clase base para excepciones específicas de la aplicación
class AppException implements Exception {
  /// Mensaje descriptivo de la excepción
  final String message;

  /// Código de error opcional
  final String? code;

  /// Error original que causó la excepción
  final Object? error;

  /// Crea una instancia de [AppException]
  const AppException({
    required this.message,
    this.code,
    this.error,
  });

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

/// Excepción para errores de red
class NetworkException extends AppException {
  const NetworkException({
    required String message,
    String? code,
    Object? error,
  }) : super(message: message, code: code, error: error);
}

/// Excepción para errores de servidor
class ServerException extends AppException {
  const ServerException({
    required String message,
    String? code,
    Object? error,
  }) : super(message: message, code: code, error: error);
}

/// Excepción para errores de caché o almacenamiento local
class CacheException extends AppException {
  const CacheException({
    required String message,
    String? code,
    Object? error,
  }) : super(message: message, code: code, error: error);
}

/// Excepción para errores de validación de datos
class ValidationException extends AppException {
  const ValidationException({
    required String message,
    String? code,
    Object? error,
  }) : super(message: message, code: code, error: error);
}
