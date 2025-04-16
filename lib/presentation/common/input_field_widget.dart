import 'package:flutter/material.dart';

/// Campo de entrada personalizado con estilo consistente
///
/// Proporciona un campo de texto estilizado con validación, iconos y otros elementos
/// siguiendo los lineamientos de Material Design.
class InputFieldWidget extends StatelessWidget {
  /// Controlador para el campo de texto
  final TextEditingController controller;

  /// Etiqueta que se muestra encima del campo
  final String label;

  /// Texto de ayuda (placeholder)
  final String hint;

  /// Icono que se muestra al inicio del campo
  final IconData icon;

  /// Determina si el texto debe ocultarse (para contraseñas)
  final bool obscureText;

  /// Tipo de teclado para el campo
  final TextInputType keyboardType;

  /// Widget opcional que se muestra al final del campo
  final Widget? suffixIcon;

  /// Función para validar el contenido del campo
  final String? Function(String?)? validator;

  /// Acción del teclado al presionar el botón de acción
  final TextInputAction? textInputAction;

  /// Función que se ejecuta cuando cambia el valor del campo
  final void Function(String)? onChanged;

  const InputFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.validator,
    this.textInputAction,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          style: TextStyle(fontSize: 16, color: theme.colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            prefixIcon: Icon(
              icon,
              size: 22,
              color: theme.colorScheme.primary.withValues(alpha: 0.7),
            ),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.3,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                width: 2,
                color: theme.colorScheme.primary,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(width: 2, color: theme.colorScheme.error),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
