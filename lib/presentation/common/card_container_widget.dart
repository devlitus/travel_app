import 'package:flutter/material.dart';

/// Widget contenedor con estilo de tarjeta que puede ser reutilizado en toda la aplicación
class CardContainerWidget extends StatelessWidget {
  /// El contenido de la tarjeta
  final Widget child;

  /// Padding interno del contenedor
  final EdgeInsetsGeometry? padding;

  /// Elevación de la tarjeta
  final double elevation;

  /// Color de la tarjeta, si es nulo usa el color de fondo del tema
  final Color? color;

  /// Margen externo del contenedor
  final EdgeInsetsGeometry? margin;

  /// Radio de las esquinas de la tarjeta
  final double borderRadius;

  /// Crea un contenedor tipo tarjeta con estilo consistente
  const CardContainerWidget({
    super.key,
    required this.child,
    this.padding,
    this.elevation = 4.0,
    this.color,
    this.margin,
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      color: color ?? Theme.of(context).colorScheme.surface,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(padding: padding ?? EdgeInsets.zero, child: child),
    );
  }
}
