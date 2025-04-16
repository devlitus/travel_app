import 'package:flutter/foundation.dart';
import '../../../domain/entities/user_entity.dart';

/// Define los posibles estados del proceso de registro
@immutable
abstract class RegisterState {
  const RegisterState();
}

/// Estado inicial cuando aún no se ha iniciado el proceso de registro
class RegisterInitial extends RegisterState {
  const RegisterInitial();
}

/// Estado de carga mientras se procesa el registro
class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

/// Estado de éxito cuando el registro se ha completado correctamente
class RegisterSuccess extends RegisterState {
  final UserEntity user;

  const RegisterSuccess(this.user);
}

/// Estado de error cuando ha ocurrido un problema durante el registro
class RegisterError extends RegisterState {
  final String message;

  const RegisterError(this.message);
}
