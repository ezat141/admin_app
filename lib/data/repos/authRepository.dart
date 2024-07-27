import 'package:admin_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> login({ required String email, required String password});
}
