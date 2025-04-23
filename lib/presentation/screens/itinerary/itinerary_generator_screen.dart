import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel/presentation/widgets/itinerary/budget_selector_widget.dart';
import 'package:travel/presentation/widgets/itinerary/destination_input_widget.dart';
import 'package:travel/presentation/widgets/itinerary/interests_selector_widget.dart';
import 'package:travel/presentation/widgets/itinerary/trip_duration_selector_widget.dart';
import '../../../core/constants/spacing.dart';
import '../../common/gradient_button_widget.dart';
import '../../common/error_message_widget.dart';
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
  final List<String> _selectedInterests = [];
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
                    const SizedBox(height: Spacing.l),
                    DestinationInputWidget(controller: _destinationController),
                    const SizedBox(height: Spacing.l),
                    TripDurationSelectorWidget(
                      days: _days,
                      onDaysChanged: (newDays) {
                        setState(() {
                          _days = newDays;
                        });
                      },
                    ),
                    const SizedBox(height: Spacing.l),
                    InterestsSelectorWidget(
                      interests: _interests,
                      selectedInterests: _selectedInterests,
                      onInterestToggled: (interest, isSelected) {
                        setState(() {
                          if (isSelected) {
                            _selectedInterests.add(interest);
                          } else {
                            _selectedInterests.remove(interest);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: Spacing.l),
                    BudgetSelectorWidget(
                      budgetOptions: _budgetOptions,
                      selectedBudget: _selectedBudget,
                      onBudgetChanged: (value) {
                        setState(() {
                          _selectedBudget = value;
                        });
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
              if (state.error != null) ErrorMessageWidget(error: state.error!),
            ],
          ),
        ),
      ),
    );
  }
}
