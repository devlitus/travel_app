import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/spacing.dart';

class BudgetSelectorWidget extends StatelessWidget {
  final List<String> budgetOptions;
  final String? selectedBudget;
  final Function(String?) onBudgetChanged;

  const BudgetSelectorWidget({
    super.key,
    required this.budgetOptions,
    this.selectedBudget,
    required this.onBudgetChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Presupuesto',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: Spacing.s),
        DropdownButtonFormField<String>(
          value: selectedBudget,
          decoration: InputDecoration(
            hintText: 'Selecciona tu presupuesto',
            prefixIcon: const Icon(Icons.account_balance_wallet),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items:
              budgetOptions.map((budget) {
                return DropdownMenuItem(
                  value: budget,
                  child: Text(
                    budget.substring(0, 1).toUpperCase() + budget.substring(1),
                  ),
                );
              }).toList(),
          onChanged: (value) {
            HapticFeedback.selectionClick();
            onBudgetChanged(value);
          },
        ),
      ],
    );
  }
}
