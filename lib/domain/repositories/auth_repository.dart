import '../entities/user_entity.dart';

/// Repositorio para gestionar la autenticación de usuarios
abstract class AuthRepository {
  /// Registra un nuevo usuario en el sistema
  Future<UserEntity> registerUser({
    required String name,
    required String email,
    required String password,
    required String preferredSeason,
  });

  /// Inicia sesión de un usuario existente
  Future<UserEntity> loginUser({
    required String email,
    required String password,
  });

  /// Cierra la sesión del usuario actual
  Future<void> logoutUser();
}
