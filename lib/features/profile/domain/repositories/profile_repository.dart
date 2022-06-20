import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../exams/data/models/user_exams_data.dart';

abstract class ProfileRepository {

  Future<Either<Failure, UserDetails>> getUserById(int userId);


  Future<Either<Failure, UserDetails>> changePassword(int userId, String newPassword);

  Future<Either<Failure, UserDetails>> changeUsername(int userId, String newUsername);

}