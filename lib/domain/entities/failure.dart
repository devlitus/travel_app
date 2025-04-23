/// Representa un error en la capa de dominio
class Failure {
  /// Mensaje descriptivo del error
  final String message;

  /// Código de error opcional
  final String? code;

  /// Error original que causó el fallo
  final Object? error;

  /// Crea una instancia de [Failure] con información detallada del error
  const Failure({
    required this.message,
    this.code,
    this.error,
  });

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}
