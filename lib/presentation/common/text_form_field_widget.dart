import 'package:flutter/material.dart';

/// Campo de formulario con validación y estilos consistentes
///
/// Proporciona un TextFormField con estilos consistentes según
/// el diseño de la aplicación.
class TextFormFieldWidget extends StatelessWidget {
  /// Controlador del campo de texto
  final TextEditingController controller;

  /// Título del campo
  final String labelText;

  /// Texto de ayuda
  final String hintText;

  /// Icono prefijo
  final IconData? prefixIcon;

  /// Widget sufijo opcional (ej. botón para alternar visibilidad)
  final Widget? suffixIcon;

  /// Tipo de entrada de teclado
  final TextInputType keyboardType;

  /// Acción al presionar enter
  final TextInputAction? textInputAction;

  /// Si debe ocultarse el texto (para contraseñas)
  final bool obscureText;

  /// Función de validación
  final String? Function(String?)? validator;

  /// Función que se llama al cambiar el valor
  final void Function(String)? onChanged;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
