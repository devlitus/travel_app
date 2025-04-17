import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Botón con fondo de gradiente personalizable
///
/// Widget que proporciona un botón con un gradiente de color personalizable,
/// con soporte para carga y feedback háptico.
class GradientButtonWidget extends StatelessWidget {
  /// Texto que se mostrará en el botón
  final String text;

  /// Acción a ejecutar cuando se presiona el botón
  final VoidCallback? onPressed;

  /// Indica si el botón está en estado de carga
  final bool isLoading;

  /// Colores del gradiente
  final List<Color>? gradientColors;

  /// Dirección del gradiente
  final Alignment begin;

  /// Dirección final del gradiente
  final Alignment end;

  /// Estilo de texto
  final TextStyle? textStyle;

  /// Radio de los bordes
  final double borderRadius;

  /// Altura del botón
  final double height;

  /// Padding interno del botón
  final EdgeInsetsGeometry? padding;

  /// Icono opcional para mostrar al lado del texto
  final IconData? icon;

  /// Posición del icono (antes o después del texto)
  final bool iconAfterText;

  /// Espacio entre el icono y el texto
  final double iconSpacing;

  /// Tamaño del indicador de carga
  final double loadingSize;

  const GradientButtonWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.gradientColors,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.textStyle,
    this.borderRadius = 16.0,
    this.height = 56.0,
    this.padding,
    this.icon,
    this.iconAfterText = false,
    this.iconSpacing = 4.0,
    this.loadingSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColors = [
      theme.colorScheme.primary,
      theme.colorScheme.primary.withOpacity(0.8),
    ];

    final effectiveColors = gradientColors ?? defaultColors;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed:
            isLoading
                ? null
                : () {
                  if (onPressed != null) {
                    // Proporcionar feedback háptico
                    HapticFeedback.lightImpact();
                    onPressed!();
                  }
                },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor:
              Colors.transparent, // Fondo transparente para el gradiente
          disabledBackgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  isLoading
                      ? [Colors.grey[400]!, Colors.grey[300]!]
                      : effectiveColors,
              begin: begin,
              end: end,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: padding ?? EdgeInsets.zero,
            alignment: Alignment.center,
            child:
                isLoading
                    ? SizedBox(
                      height: loadingSize,
                      width: loadingSize,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    const defaultTextStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      color: Colors.white,
    );

    final effectiveTextStyle = textStyle ?? defaultTextStyle;

    if (icon == null) {
      return Text(text, style: effectiveTextStyle);
    }

    final iconWidget = Icon(icon, color: effectiveTextStyle.color, size: 18);

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          iconAfterText
              ? [
                Text(text, style: effectiveTextStyle),
                SizedBox(width: iconSpacing),
                iconWidget,
              ]
              : [
                iconWidget,
                SizedBox(width: iconSpacing),
                Text(text, style: effectiveTextStyle),
              ],
    );
  }
}
