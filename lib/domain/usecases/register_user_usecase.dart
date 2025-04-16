import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Caso de uso para el registro de usuarios
class RegisterUserUseCase {
  final AuthRepository _repository;

  /// Constructor que recibe el repositorio como dependencia
  RegisterUserUseCase(this._repository);

  /// Método para ejecutar el caso de uso
  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
    required String preferredSeason,
  }) async {
    return await _repository.registerUser(
      name,
      email,
      password,
      preferredSeason,
    );
  }
}
