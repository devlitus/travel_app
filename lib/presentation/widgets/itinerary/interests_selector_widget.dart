import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/spacing.dart';

class InterestsSelectorWidget extends StatelessWidget {
  final List<String> interests;
  final List<String> selectedInterests;
  final Function(String, bool) onInterestToggled;

  const InterestsSelectorWidget({
    super.key,
    required this.interests,
    required this.selectedInterests,
    required this.onInterestToggled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Intereses',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: Spacing.s),
        Wrap(
          spacing: Spacing.s,
          runSpacing: Spacing.s,
          children:
              interests.map((interest) {
                final isSelected = selectedInterests.contains(interest);
                return FilterChip(
                  label: Text(interest),
                  selected: isSelected,
                  showCheckmark: false,
                  avatar:
                      isSelected
                          ? Icon(
                            Icons.check_circle,
                            color: theme.colorScheme.primary,
                            size: 18,
                          )
                          : null,
                  onSelected: (selected) {
                    HapticFeedback.selectionClick();
                    onInterestToggled(interest, selected);
                  },
                );
              }).toList(),
        ),
      ],
    );
  }
}
