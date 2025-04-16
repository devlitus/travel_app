import 'package:flutter/material.dart';

/// Widget para mostrar una estación en el dropdown
///
/// Muestra el nombre de la estación con un icono representativo
/// y color correspondiente.
class SeasonDropdownItemWidget extends StatelessWidget {
  /// Nombre de la estación
  final String season;

  const SeasonDropdownItemWidget({super.key, required this.season});

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final Color color;

    // Determinar el icono y color según la estación
    switch (season) {
      case 'Primavera':
        icon = Icons.local_florist;
        color = Colors.pink.shade300; // Rosa floreciente para primavera
        break;
      case 'Verano':
        icon = Icons.wb_sunny;
        color = Colors.amber.shade600; // Amarillo cálido para verano
        break;
      case 'Otoño':
        icon = Icons.eco;
        color = Colors.orange.shade700; // Naranja para otoño
        break;
      case 'Invierno':
        icon = Icons.ac_unit;
        color = Colors.lightBlue.shade300; // Azul claro para invierno
        break;
      default:
        icon = Icons.calendar_today;
        color = Theme.of(context).colorScheme.primary;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: Text(season, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}
