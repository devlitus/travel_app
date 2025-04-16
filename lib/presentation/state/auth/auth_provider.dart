import 'package:flutter_riverpod/flutter_riverpod.dart';

// Estado de autenticación
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;
  final String? token;
  final String? userId;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
    this.token,
    this.userId,
  });

  // Crear una copia del estado con nuevos valores
  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    String? token,
    String? userId,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error ?? this.error,
      token: token ?? this.token,
      userId: userId ?? this.userId,
    );
  }
}

// Notificador para manejar la autenticación
class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<void> login(String email, String password) async {
    // Establecer estado de carga
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Simular una llamada de API para autenticación
      await Future.delayed(const Duration(seconds: 2));

      // Validaciones básicas
      if (email.isEmpty || password.isEmpty) {
        throw Exception('El correo y contraseña son obligatorios');
      }

      if (!email.contains('@')) {
        throw Exception('Correo electrónico inválido');
      }

      if (password.length < 6) {
        throw Exception('La contraseña debe tener al menos 6 caracteres');
      }

      // Para fines de demostración, aceptar cualquier correo/contraseña válida
      // En una implementación real, aquí se usaría un servicio de autenticación
      final String mockToken =
          'jwt-token-${DateTime.now().millisecondsSinceEpoch}';
      final String mockUserId = 'user-123';

      // Actualizar estado con la autenticación exitosa
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        token: mockToken,
        userId: mockUserId,
      );
    } catch (e) {
      // Manejar errores de autenticación
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        error: e.toString(),
      );
    }
  }

  void logout() {
    state = const AuthState();
  }
}

// Provider para el notificador de autenticación
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  return AuthNotifier();
});
