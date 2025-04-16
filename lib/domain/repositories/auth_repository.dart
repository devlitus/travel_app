import 'package:travel/domain/entities/user_entity.dart';

/// Interfaz que define las operaciones de autenticación
abstract class AuthRepository {
  /// Inicia sesión con email y contraseña
  Future<UserEntity> loginUser(String email, String password);

  /// Cierra la sesión del usuario actual
  Future<void> logoutUser();

  /// Verifica si hay una sesión activa
  Future<UserEntity?> getCurrentUser();

  /// Registra un nuevo usuario
  Future<UserEntity> registerUser(
    String name,
    String email,
    String password,
    String preferredSeason,
  );

  /// Restablece la contraseña
  Future<void> resetPassword(String email);
}
