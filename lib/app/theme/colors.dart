import 'package:flutter/material.dart';

/// Clase que define la paleta de colores para la aplicación de viajes.
///
/// Sigue una estructura semántica donde los colores representan acciones
/// o elementos específicos de la interfaz en lugar de nombres genéricos.
class TravelColors {
  // Colores primarios
  static const Color primary = Color(
    0xFF1A73E8,
  ); // Azul vibrante para acción principal
  static const Color secondary = Color(
    0xFFFFA000,
  ); // Ámbar para destacados y CTA secundarios
  static const Color tertiary = Color(0xFF00BFA5); // Verde azulado para acentos

  // Variaciones del color primario
  static const Color primaryLight = Color(0xFF5EA1FF);
  static const Color primaryDark = Color(0xFF0045B5);

  // Colores de estado
  static const Color success = Color(0xFF4CAF50); // Verde para éxito
  static const Color error = Color(0xFFE53935); // Rojo para error
  static const Color warning = Color(0xFFFFC107); // Ámbar para advertencias
  static const Color info = Color(0xFF2196F3); // Azul cielo para información

  // Colores neutros
  static const Color background = Color(0xFFF8F9FA); // Fondo principal claro
  static const Color surface =
      Colors.white; // Superficie de tarjetas y elementos
  static const Color onSurface = Color(
    0xFF202124,
  ); // Texto principal sobre superficie
  static const Color onBackground = Color(
    0xFF202124,
  ); // Texto principal sobre fondo

  // Colores específicos para viajes
  static const Color destination = Color(0xFF0288D1); // Azul destinos
  static const Color hotel = Color(0xFF7CB342); // Verde hoteles
  static const Color flight = Color(0xFF039BE5); // Azul claro vuelos
  static const Color activity = Color(0xFFFF6D00); // Naranja actividades
  static const Color favorite = Color(0xFFE91E63); // Rosa favoritos

  // Colores para elementos de UI
  static const Color divider = Color(0xFFDEDEDE); // Divisor sutil
  static const Color disabled = Color(0xFF9E9E9E); // Elementos deshabilitados
  static const Color navigationBar = primary; // Barra de navegación
  static const Color cardShadow = Color(
    0x1A000000,
  ); // Sombra de tarjetas (10% opacidad)

  // Modo oscuro
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color onDarkSurface = Color(0xFFF1F3F4);
  static const Color onDarkBackground = Color(0xFFF1F3F4);
}
