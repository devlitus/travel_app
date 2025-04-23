import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_exception.dart';
import '../entities/failure.dart';

/// Mixin que proporciona funcionalidad común para todos los repositorios
mixin BaseRepository {
  /// Ejecuta una acción asíncrona y maneja sus excepciones
  ///
  /// Convierte excepciones específicas en tipos de [Failure] apropiados
  /// y devuelve un [Either] para manejar el resultado o error de forma segura
  ///
  /// [action] - Función a ejecutar que devuelve un [Future] con el resultado
  Future<Either<Failure, T>> execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on NetworkException catch (e) {
      return Left(Failure(
        message: e.message,
        code: e.code,
        error: e,
      ));
    } on ServerException catch (e) {
      return Left(Failure(
        message: e.message,
        code: e.code,
        error: e,
      ));
    } on CacheException catch (e) {
      return Left(Failure(
        message: e.message,
        code: e.code,
        error: e,
      ));
    } on ValidationException catch (e) {
      return Left(Failure(
        message: e.message,
        code: e.code,
        error: e,
      ));
    } on SocketException catch (e) {
      return Left(Failure(
        message: 'Error de conexión: ${e.message}',
        error: e,
      ));
    } on FormatException catch (e) {
      return Left(Failure(
        message: 'Error de formato de datos: ${e.message}',
        error: e,
      ));
    } catch (e) {
      return Left(Failure(
        message: 'Error inesperado: ${e.toString()}',
        error: e,
      ));
    }
  }
}
