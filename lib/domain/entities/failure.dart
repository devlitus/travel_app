/// Clase base para representar fallos en la aplicación
class Failure {
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;

  const Failure({required this.message, this.error, this.stackTrace});

  @override
  String toString() => message;
}
