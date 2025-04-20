import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/spacing.dart';
import '../../common/gradient_button_widget.dart';
import '../../state/itinerary/itinerary_provider.dart';

class ItineraryGeneratorScreen extends ConsumerStatefulWidget {
  const ItineraryGeneratorScreen({super.key});

  static const String routeName = '/itinerary-generator';

  @override
  ConsumerState<ItineraryGeneratorScreen> createState() =>
      _ItineraryGeneratorScreenState();
}

class _ItineraryGeneratorScreenState
    extends ConsumerState<ItineraryGeneratorScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  int _days = 3;
  List<String> _selectedInterests = [];
  String? _selectedBudget;
  bool _isFirstBuild = true;
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  final List<String> _interests = [
    'Cultura',
    'Gastronomía',
    'Naturaleza',
    'Aventura',
    'Historia',
    'Arte',
    'Compras',
    'Relax',
  ];

  final List<String> _budgetOptions = ['económico', 'moderado', 'lujo'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _generateItinerary() {
    if (_formKey.currentState!.validate()) {
      HapticFeedback.mediumImpact();
      ref
          .read(itineraryProvider.notifier)
          .generateItinerary(
            _destinationController.text,
            days: _days,
            interests:
                _selectedInterests.isNotEmpty ? _selectedInterests : null,
            budget: _selectedBudget,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(itineraryProvider);
    final theme = Theme.of(context);

    // Manejar la navegación cuando el itinerario esté listo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isFirstBuild && !state.isLoading && state.itinerary != null) {
        Navigator.pushNamed(
          context,
          '/itinerary-details',
          arguments: {
            'destination': _destinationController.text,
            'itinerary': state.itinerary!,
          },
        );
      }
      _isFirstBuild = false;
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Generar Itinerario'), elevation: 0),
      body: FadeTransition(
        opacity: _fadeInAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Spacing.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: Column(
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
                      controller: _destinationController,
                      decoration: InputDecoration(
                        labelText: 'Destino',
                        hintText: 'Ej: París, Roma, Barcelona...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa un destino';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: Spacing.l),
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
                            value: _days.toDouble(),
                            min: 1,
                            max: 7,
                            divisions: 6,
                            label: '$_days días',
                            onChanged: (value) {
                              HapticFeedback.selectionClick();
                              setState(() => _days = value.round());
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
                            '$_days días',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.l),
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
                          _interests.map((interest) {
                            final isSelected = _selectedInterests.contains(
                              interest,
                            );
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
                                setState(() {
                                  if (selected) {
                                    _selectedInterests.add(interest);
                                  } else {
                                    _selectedInterests.remove(interest);
                                  }
                                });
                              },
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: Spacing.l),
                    Text(
                      'Presupuesto',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: Spacing.s),
                    DropdownButtonFormField<String>(
                      value: _selectedBudget,
                      decoration: InputDecoration(
                        hintText: 'Selecciona tu presupuesto',
                        prefixIcon: const Icon(Icons.account_balance_wallet),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items:
                          _budgetOptions.map((budget) {
                            return DropdownMenuItem(
                              value: budget,
                              child: Text(
                                budget.substring(0, 1).toUpperCase() +
                                    budget.substring(1),
                              ),
                            );
                          }).toList(),
                      onChanged: (value) {
                        HapticFeedback.selectionClick();
                        setState(() => _selectedBudget = value);
                      },
                    ),
                    const SizedBox(height: Spacing.xl),
                    GradientButtonWidget(
                      text: 'Generar Itinerario',
                      onPressed: state.isLoading ? null : _generateItinerary,
                      isLoading: state.isLoading,
                      icon: Icons.route,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacing.l),
              if (state.error != null)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Card(
                    color: theme.colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(Spacing.m),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: theme.colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: Spacing.m),
                          Expanded(
                            child: Text(
                              state.error!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
