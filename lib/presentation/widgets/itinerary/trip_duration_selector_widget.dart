import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/spacing.dart';

class TripDurationSelectorWidget extends StatelessWidget {
  final int days;
  final Function(int) onDaysChanged;

  const TripDurationSelectorWidget({
    super.key,
    required this.days,
    required this.onDaysChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Duración del viaje',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: days.toDouble(),
                min: 1,
                max: 7,
                divisions: 6,
                label: '$days días',
                onChanged: (value) {
                  HapticFeedback.selectionClick();
                  onDaysChanged(value.round());
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.m,
                vertical: Spacing.s,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$days días',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
