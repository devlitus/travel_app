import 'package:dartz/dartz.dart';
import '../entities/failure.dart';

/// Interfaz base para todos los repositorios
abstract class BaseRepository {
  Future<Either<Failure, T>> execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
