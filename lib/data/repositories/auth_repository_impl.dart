import 'package:travel/domain/entities/user_entity.dart';
import 'package:travel/domain/repositories/auth_repository.dart';

/// Implementación del repositorio de autenticación
class AuthRepositoryImpl implements AuthRepository {
  // Aquí podrías inyectar las fuentes de datos (API, local storage, etc.)
  // AuthDatasource _authDatasource;

  // Simulación para demo - reemplazar con implementación real
  @override
  Future<UserEntity> loginUser(String email, String password) async {
    // Simular un retraso de red
    await Future.delayed(const Duration(seconds: 1));

    // En una implementación real, se validaría con un backend
    if (email == 'test@ejemplo.com' && password == '12345678') {
      return const UserEntity(
        id: '1',
        name: 'Usuario Ejemplo',
        email: 'usuario@ejemplo.com',
        preferredSeason: 'Verano',
      );
    } else {
      throw Exception('Credenciales inválidas');
    }
  }

  @override
  Future<void> logoutUser() async {
    // Simula cierre de sesión
    await Future.delayed(const Duration(milliseconds: 300));
    // En implementación real: eliminar token de SharedPreferences, etc.
    return;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    // En una implementación real, verificaría si hay un token válido
    // y obtendría la información del usuario desde SharedPreferences o API
    return null; // Por ahora retornamos null (no autenticado)
  }

  @override
  Future<UserEntity> registerUser(
    String name,
    String email,
    String password,
    String preferredSeason,
  ) async {
    // Simular un retraso de red
    await Future.delayed(const Duration(seconds: 1));

    // En implementación real: enviar datos al servidor y recibir respuesta
    return UserEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      preferredSeason: preferredSeason,
    );
  }

  @override
  Future<void> resetPassword(String email) async {
    // Simular retraso de red
    await Future.delayed(const Duration(seconds: 1));

    // En implementación real: llamar a API para solicitar restablecimiento
    return;
  }
}
