import 'package:travel/domain/entities/user_entity.dart';
import 'package:travel/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  const LoginUseCase(this._authRepository);

  Future<UserEntity> call(String email, String password) {
    return _authRepository.loginUser(email, password);
  }
}
