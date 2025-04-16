import 'package:flutter/material.dart';
import '../../../app/theme/styles.dart';

/// Widget de menú desplegable personalizado con iconos y colores
///
/// Proporciona un selector desplegable con estilo consistente y
/// soporte para iconos en las opciones.
class CustomDropdownWidget<T> extends StatelessWidget {
  /// Valor actualmente seleccionado
  final T value;

  /// Lista de elementos para mostrar
  final List<T> items;

  /// Función para mapear cada elemento a un widget
  final Widget Function(T) itemBuilder;

  /// Título del campo
  final String labelText;

  /// Icono prefijo
  final IconData? prefixIcon;

  /// Función que se ejecuta al cambiar la selección
  final void Function(T?)? onChanged;

  /// Decoración adicional para el contenedor
  final BoxDecoration? decoration;

  const CustomDropdownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.itemBuilder,
    required this.labelText,
    this.prefixIcon,
    this.onChanged,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            labelText,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ),
        Container(
          decoration:
              decoration ??
              BoxDecoration(
                border: Border.all(color: const Color(0xFFDDDDDD), width: 1),
                borderRadius: TravelStyles.borderRadiusAllS,
                color: Colors.white,
              ),
          child: DropdownButtonFormField<T>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: TravelStyles.spaceM,
                vertical: TravelStyles.spaceS,
              ),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            value: value,
            isExpanded: true,
            icon: const Padding(
              padding: EdgeInsets.only(right: TravelStyles.spaceXS),
              child: Icon(Icons.arrow_drop_down, size: 24),
            ),
            iconSize: 24,
            elevation: 16,
            alignment: Alignment.center,
            style: theme.textTheme.bodyMedium,
            dropdownColor: Colors.white,
            borderRadius: TravelStyles.borderRadiusAllS,
            onChanged: onChanged,
            items:
                items.map<DropdownMenuItem<T>>((T item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    alignment: Alignment.center,
                    child: itemBuilder(item),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
