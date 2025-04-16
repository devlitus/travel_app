import 'package:travel/domain/entities/user_entity.dart';

/// Representa el estado de autenticación en la aplicación
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final UserEntity? user;
  final String? errorMessage;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.user,
    this.errorMessage,
  });

  // Estado inicial: no autenticado, no cargando
  factory AuthState.initial() => const AuthState();

  // Estado de carga durante el proceso de autenticación
  factory AuthState.loading() => const AuthState(isLoading: true);

  // Estado autenticado con información del usuario
  factory AuthState.authenticated(UserEntity user) =>
      AuthState(isAuthenticated: true, user: user);

  // Estado de error de autenticación
  factory AuthState.error(String message) => AuthState(errorMessage: message);

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    UserEntity? user,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
