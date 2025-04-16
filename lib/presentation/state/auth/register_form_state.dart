import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Estado del formulario de registro que mantiene los valores y controla la validación
class RegisterFormState {
  /// Controlador para el campo de nombre
  final TextEditingController nameController;

  /// Controlador para el campo de email
  final TextEditingController emailController;

  /// Controlador para el campo de contraseña
  final TextEditingController passwordController;

  /// Estación del año seleccionada por el usuario
  final String selectedSeason;

  /// Si la contraseña es visible o no
  final bool isPasswordVisible;

  /// Constructor del estado del formulario
  RegisterFormState({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.selectedSeason,
    required this.isPasswordVisible,
  });

  /// Constructor de fábrica para crear una instancia con valores iniciales
  factory RegisterFormState.initial() {
    return RegisterFormState(
      nameController: TextEditingController(),
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      selectedSeason: 'Primavera',
      isPasswordVisible: false,
    );
  }

  /// Crea una copia del estado con algunos valores modificados
  RegisterFormState copyWith({
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    String? selectedSeason,
    bool? isPasswordVisible,
  }) {
    return RegisterFormState(
      nameController: nameController ?? this.nameController,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      selectedSeason: selectedSeason ?? this.selectedSeason,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}

/// Proveedor global para el estado del formulario de registro
final registerFormProvider =
    StateNotifierProvider<RegisterFormNotifier, RegisterFormState>((ref) {
      return RegisterFormNotifier();
    });

/// Notificador de estado para el formulario de registro
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  /// Constructor que inicializa el estado
  RegisterFormNotifier() : super(RegisterFormState.initial());

  /// Actualiza la visibilidad de la contraseña
  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  /// Actualiza la estación seleccionada
  void updateSelectedSeason(String season) {
    state = state.copyWith(selectedSeason: season);
  }

  @override
  void dispose() {
    state.nameController.dispose();
    state.emailController.dispose();
    state.passwordController.dispose();
    super.dispose();
  }
}
