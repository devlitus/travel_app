import 'package:flutter/material.dart';

/// Clase de utilidad para mantener consistencia en los espaciados
/// de la aplicación basados en múltiplos de 8px
class Spacing {
  /// Extra pequeño: 4.0
  static const double xs = 4.0;

  /// Pequeño: 8.0
  static const double s = 8.0;

  /// Mediano: 16.0
  static const double m = 16.0;

  /// Grande: 24.0
  static const double l = 24.0;

  /// Extra grande: 32.0
  static const double xl = 32.0;

  /// Doble extra grande: 48.0
  static const double xxl = 48.0;

  /// Crea paddings verticales con el valor especificado
  static EdgeInsets verticalOnly(double value) =>
      EdgeInsets.symmetric(vertical: value);

  /// Crea paddings horizontales con el valor especificado
  static EdgeInsets horizontalOnly(double value) =>
      EdgeInsets.symmetric(horizontal: value);

  /// Crea paddings en todas direcciones con el valor especificado
  static EdgeInsets all(double value) => EdgeInsets.all(value);

  /// Crea un SizedBox con la altura especificada
  static SizedBox height(double height) => SizedBox(height: height);

  /// Crea un SizedBox con el ancho especificado
  static SizedBox width(double width) => SizedBox(width: width);
}
