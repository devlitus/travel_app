import 'package:flutter/material.dart';
import '../../core/constants/spacing.dart';

/// Widget reutilizable que muestra un indicador de carga con mensaje opcional
class LoadingIndicatorWidget extends StatelessWidget {
  /// Mensaje que se mostrará debajo del indicador de carga
  final String? message;

  /// Color del indicador de carga, por defecto usa el colorScheme.primary del tema
  final Color? color;

  /// Tamaño del indicador de carga
  final double size;

  /// Constructor para el widget de indicador de carga
  const LoadingIndicatorWidget({
    super.key,
    this.message,
    this.color,
    this.size = 32.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: Spacing.m),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
