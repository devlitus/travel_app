import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel/data/providers/auth_repository_provider.dart';
import 'package:travel/domain/entities/auth_state.dart';
import 'package:travel/domain/repositories/auth_repository.dart';

part 'auth_notifier.g.dart';

/// Notifier que maneja el estado de autenticación de la aplicación
@riverpod
class AuthNotifier extends _$AuthNotifier {
  late AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.read(authRepositoryProvider);

    // Intentar recuperar la sesión al iniciar la aplicación
    _restoreSession();

    return AuthState.initial();
  }

  /// Intenta restaurar una sesión previa
  Future<void> _restoreSession() async {
    try {
      state = AuthState.loading();

      final user = await _authRepository.getCurrentUser();

      if (user != null) {
        state = AuthState.authenticated(user);
      } else {
        state = AuthState.initial();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al restaurar sesión: $e');
      }
      state = AuthState.initial();
    }
  }

  /// Inicia sesión con email y contraseña
  Future<void> loginUser(String email, String password) async {
    try {
      state = AuthState.loading();

      final user = await _authRepository.loginUser(email, password);

      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Cierra la sesión actual
  Future<void> logoutUser() async {
    try {
      state = AuthState.loading();

      await _authRepository.logoutUser();

      state = AuthState.initial();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Registra un nuevo usuario
  Future<void> registerUser(
    String name,
    String email,
    String password,
    String preferredSeason,
  ) async {
    try {
      state = AuthState.loading();

      final user = await _authRepository.registerUser(
        name,
        email,
        password,
        preferredSeason,
      );

      state = AuthState.authenticated(user);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Solicita restablecer la contraseña
  Future<void> resetPassword(String email) async {
    try {
      state = state.copyWith(isLoading: true);

      await _authRepository.resetPassword(email);

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  /// Limpia cualquier error presente en el estado
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(errorMessage: null);
    }
  }
}
