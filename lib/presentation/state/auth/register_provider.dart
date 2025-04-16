import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecases/register_user_usecase.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import 'register_state.dart';

/// Provider para el caso de uso de registro
final registerUseCaseProvider = Provider<RegisterUserUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return RegisterUserUseCase(authRepository);
});

/// Provider para el repositorio de autenticación
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  // Por ahora creamos una implementación mock para pruebas
  // En una versión real, aquí se inyectarían las dependencias necesarias
  return AuthRepositoryImpl();
});

/// Provider para manejar el estado del registro
final registerStateProvider =
    StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
      final registerUseCase = ref.watch(registerUseCaseProvider);
      return RegisterNotifier(registerUseCase);
    });

/// Notificador para manejar los cambios de estado durante el proceso de registro
class RegisterNotifier extends StateNotifier<RegisterState> {
  final RegisterUserUseCase _registerUserUseCase;

  /// Constructor que recibe el caso de uso como dependencia
  RegisterNotifier(this._registerUserUseCase) : super(const RegisterInitial());

  /// Método para iniciar el proceso de registro
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String preferredSeason,
  }) async {
    // Cambiar a estado de carga
    state = const RegisterLoading();

    try {
      // Intenta registrar al usuario
      final user = await _registerUserUseCase(
        name: name,
        email: email,
        password: password,
        preferredSeason: preferredSeason,
      );

      // Si hay éxito, actualiza el estado
      state = RegisterSuccess(user);
    } catch (e) {
      // Si hay un error, actualiza el estado con el mensaje de error
      state = RegisterError(e.toString());
    }
  }

  /// Método para resetear el estado a inicial
  void reset() {
    state = const RegisterInitial();
  }
}
