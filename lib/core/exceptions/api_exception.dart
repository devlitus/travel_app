/// Excepción personalizada para errores relacionados con APIs
class ApiException implements Exception {
  final String message;
  final String? details;
  final int? statusCode;

  const ApiException(this.message, [this.details, this.statusCode]);

  @override
  String toString() {
    String result = 'ApiException: $message';
    if (details != null) result += ' - $details';
    if (statusCode != null) result += ' (Code: $statusCode)';
    return result;
  }
}
