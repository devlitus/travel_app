import 'package:flutter/material.dart';
import '../../../core/constants/spacing.dart';

class DestinationInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const DestinationInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¿A dónde te gustaría ir?',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: Spacing.s),
        Text(
          'Personaliza tu viaje ideal respondiendo estas preguntas',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: Spacing.l),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Destino',
            hintText: 'Ej: París, Roma, Barcelona...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa un destino';
            }
            return null;
          },
        ),
      ],
    );
  }
}
