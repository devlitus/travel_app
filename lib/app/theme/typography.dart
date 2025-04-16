import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Define el sistema tipográfico para la aplicación de viajes.
///
/// Utiliza Google Fonts y establece una jerarquía clara para diferentes propósitos.
class TravelTypography {
  // Fuente principal para títulos
  static String get _headingFontFamily => GoogleFonts.montserrat().fontFamily!;

  // Fuente para cuerpo de texto
  static String get _bodyFontFamily => GoogleFonts.roboto().fontFamily!;

  /// Configuración de estilo para los textos de la aplicación
  static TextTheme textTheme = TextTheme(
    // Títulos grandes para pantallas principales
    headlineLarge: TextStyle(
      fontFamily: _headingFontFamily,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    ),

    // Títulos medianos para encabezados de secciones
    headlineMedium: TextStyle(
      fontFamily: _headingFontFamily,
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.25,
    ),

    // Títulos pequeños para subsecciones
    headlineSmall: TextStyle(
      fontFamily: _headingFontFamily,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
    ),

    // Títulos de tarjetas o elementos destacados
    titleLarge: TextStyle(
      fontFamily: _headingFontFamily,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
    ),

    // Subtítulos (nombre de hoteles, destinos, etc.)
    titleMedium: TextStyle(
      fontFamily: _headingFontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
    ),

    // Etiquetas y elementos pequeños destacados
    titleSmall: TextStyle(
      fontFamily: _headingFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
    ),

    // Texto de cuerpo grande (descripciones principales)
    bodyLarge: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
    ),

    // Texto de cuerpo estándar
    bodyMedium: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.4,
    ),

    // Texto pequeño (detalles, información secundaria)
    bodySmall: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.3,
    ),

    // Etiqueta para botones
    labelLarge: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),

    // Etiquetas más pequeñas
    labelSmall: TextStyle(
      fontFamily: _bodyFontFamily,
      fontSize: 10,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.5,
    ),
  );
}
