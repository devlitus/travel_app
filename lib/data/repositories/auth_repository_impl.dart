import 'package:flutter/foundation.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

/// Implementación del repositorio de autenticación
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserEntity> loginUser({
    required String email,
    required String password,
  }) async {
    // Simulamos una demora de red
    await Future.delayed(const Duration(seconds: 1));

    // Simulamos validación de credenciales
    if (email == 'test@example.com' && password == 'password123') {
      return const UserEntity(
        id: '1',
        name: 'Usuario de Prueba',
        email: 'test@example.com',
        preferredSeason: 'Primavera',
      );
    } else {
      // Simulamos un error de autenticación
      throw Exception('Credenciales incorrectas');
    }
  }

  @override
  Future<void> logoutUser() async {
    // Simulamos una demora de red
    await Future.delayed(const Duration(milliseconds: 500));

    // En una implementación real, aquí eliminaríamos tokens, sesiones, etc.
    debugPrint('Usuario cerró sesión');
    return;
  }

  @override
  Future<UserEntity> registerUser({
    required String name,
    required String email,
    required String password,
    required String preferredSeason,
  }) async {
    // Simulamos una demora de red
    await Future.delayed(const Duration(seconds: 2));

    // Validamos el formato del email (simplificado)
    if (!email.contains('@')) {
      throw Exception('El formato del correo electrónico no es válido');
    }

    // Validamos la longitud de la contraseña
    if (password.length < 6) {
      throw Exception('La contraseña debe tener al menos 6 caracteres');
    }

    // En una implementación real, aquí haríamos la llamada API
    // Por ahora simulamos éxito y retornamos un usuario con un ID generado
    return UserEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      preferredSeason: preferredSeason,
    );
  }
}
