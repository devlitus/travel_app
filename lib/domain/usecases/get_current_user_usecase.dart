import 'package:travel/domain/entities/user_entity.dart';
import 'package:travel/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _authRepository;

  const GetCurrentUserUseCase(this._authRepository);

  Future<UserEntity?> call() {
    return _authRepository.getCurrentUser();
  }
}
