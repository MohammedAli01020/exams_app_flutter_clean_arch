
import 'package:dartz/dartz.dart';
import 'package:exams_app/features/exams/data/models/user_exams_data.dart';

import '../../../../core/error/failures.dart';
import '../entities/current_user.dart';
import '../use_cases/login_use_cases.dart';


abstract class LoginRepository {
  Future<Either<Failure, CurrentUser>> login(LoginParam loginParam);
  void logout();
  Future<Either<Failure, CurrentUser>> getSavedCredentials();

  Future<Either<Failure, void>> sendEmailToUser(String username, String email);

  Future<Either<Failure, UserDetails>> getUserByEmail(String username);

  Future<Either<Failure, void>> cacheCurrentUser(CurrentUser currentUser);

  Future<Either<Failure, UserDetails>> changePasswordByUsername(String username, String newPassword);



}