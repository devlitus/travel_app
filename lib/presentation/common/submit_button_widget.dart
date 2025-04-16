import 'package:flutter/material.dart';

/// Botón de envío con estado de carga
///
/// Proporciona un botón para formularios que muestra un indicador de carga
/// durante operaciones asíncronas.
class SubmitButtonWidget extends StatelessWidget {
  /// Texto a mostrar en el botón
  final String text;

  /// Función a ejecutar al presionar el botón
  final VoidCallback? onPressed;

  /// Indica si está en estado de carga
  final bool isLoading;

  const SubmitButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: CircularProgressIndicator(),
          ),
        )
        : ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: Text(text),
        );
  }
}
