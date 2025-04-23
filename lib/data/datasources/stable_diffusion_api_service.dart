import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:travel/core/exceptions/app_exception.dart';
import 'package:travel/core/constants/api_constants.dart';

/// Servicio para interactuar con la API de Stable Diffusion
class StableDiffusionApiService {
  final http.Client _httpClient;

  /// Constructor del servicio
  StableDiffusionApiService({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  /// Genera una imagen con Stable Diffusion basada en un prompt
  ///
  /// [prompt] es el texto descriptivo para generar la imagen
  /// [height] altura de la imagen (por defecto 512)
  /// [width] ancho de la imagen (por defecto 512)
  /// [steps] número de pasos de inferencia (por defecto 30)
  ///
  /// Devuelve un [Uint8List] con los bytes de la imagen generada
  /// o lanza un [AppException] en caso de error
  Future<Uint8List> generateImage({
    required String prompt,
    int height = 512,
    int width = 512,
    int steps = 30,
  }) async {
    try {
      final response = await _httpClient.post(
        Uri.parse(ApiConstants.stableDiffusionApiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${ApiConstants.stableDiffusionApiKey}',
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 1,
          'size': '${width}x$height',
          'response_format': 'b64_json',
          'steps': steps,
          'guidance_scale': 7.5,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('images') &&
            responseData['images'] is List &&
            responseData['images'].isNotEmpty) {
          final String base64Image = responseData['images'][0]['b64_json'];
          return base64Decode(base64Image);
        } else {
          throw const AppException(
            message: 'Formato de respuesta inesperado de la API',
            code: 'UNEXPECTED_RESPONSE_FORMAT',
          );
        }
      } else {
        throw AppException(
          message: 'Error al generar imagen: ${response.statusCode}',
          code: 'API_ERROR',
          error: response.body,
        );
      }
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw AppException(
        message: 'Error al conectar con la API de Stable Diffusion',
        code: 'CONNECTION_ERROR',
        error: e.toString(),
      );
    }
  }

  /// Genera un prompt mejorado basado en el destino
  ///
  /// [destination] nombre del destino
  /// [context] contexto adicional opcional (temporada, intereses, etc.)
  ///
  /// Devuelve un string con el prompt elaborado
  String generateEnhancedPrompt(String destination, {String? context}) {
    final basePrompt = 'Fotografía panorámica de alta calidad de $destination, '
        'mostrando sus principales atracciones turísticas al atardecer';

    if (context != null && context.isNotEmpty) {
      return '$basePrompt, $context';
    }

    return basePrompt;
  }
}
