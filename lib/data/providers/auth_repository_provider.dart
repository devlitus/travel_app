import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel/data/repositories/auth_repository_impl.dart';
import 'package:travel/domain/repositories/auth_repository.dart';

/// Provider para el repositorio de autenticación
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});
