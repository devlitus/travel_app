import 'package:flutter/material.dart';
import '../../core/constants/spacing.dart';

/// Widget reutilizable para mostrar mensajes de error en toda la aplicación.
///
/// Muestra un mensaje de error en un contenedor con color de fondo y estilo
/// consistentes con el tema de la aplicación.
class ErrorMessageWidget extends StatelessWidget {
  /// El texto del mensaje de error que se mostrará.
  final String error;

  /// Icono opcional para mostrar junto al mensaje de error.
  final IconData? icon;

  /// Animación opcional para la entrada del mensaje de error.
  final bool animate;

  const ErrorMessageWidget({
    super.key,
    required this.error,
    this.icon = Icons.error_outline,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final errorWidget = Card(
      color: theme.colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(Spacing.m),
        child: Row(
          children: [
            if (icon != null)
              Icon(icon, color: theme.colorScheme.onErrorContainer),
            if (icon != null) const SizedBox(width: Spacing.m),
            Expanded(
              child: Text(
                error,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (animate) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: errorWidget,
      );
    }

    return errorWidget;
  }
}
