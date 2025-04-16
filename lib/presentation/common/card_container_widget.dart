import 'package:flutter/material.dart';

/// Contenedor con apariencia de tarjeta para diferentes secciones de la UI
///
/// Proporciona un contenedor estilizado con bordes redondeados, sombras y padding
/// personalizable para mantener una apariencia consistente en toda la aplicación.
class CardContainerWidget extends StatelessWidget {
  /// Widget hijo que se muestra dentro del contenedor
  final Widget child;

  /// Padding interno del contenedor
  final EdgeInsetsGeometry padding;

  /// Color del fondo de la tarjeta
  final Color? backgroundColor;

  /// Radio de las esquinas redondeadas
  final double borderRadius;

  /// Elevación de la sombra
  final double elevation;

  /// Margen externo del contenedor
  final EdgeInsetsGeometry? margin;

  const CardContainerWidget({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.backgroundColor,
    this.borderRadius = 24.0,
    this.elevation = 2.0,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final color = backgroundColor ?? Theme.of(context).colorScheme.surface;

    return Container(
      width: double.infinity,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation * 6,
            offset: Offset(0, elevation * 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
