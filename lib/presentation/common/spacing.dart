import 'package:flutter/material.dart';

/// Clase para mantener consistencia en los espaciados de la aplicación
///
/// Proporciona valores constantes para espaciados basados en múltiplos de 4
/// siguiendo los lineamientos de Material Design.
class Spacing {
  /// Espaciado extra pequeño - 4.0
  static const double xs = 4.0;

  /// Espaciado pequeño - 8.0
  static const double s = 8.0;

  /// Espaciado medio - 16.0
  static const double m = 16.0;

  /// Espaciado grande - 24.0
  static const double l = 24.0;

  /// Espaciado extra grande - 32.0
  static const double xl = 32.0;

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
