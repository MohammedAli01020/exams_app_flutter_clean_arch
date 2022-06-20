import 'package:exams_app/core/error/failures.dart';

import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:exams_app/features/exams/data/models/user_exams_data.dart';
import 'package:exams_app/features/login/data/models/current_user_model.dart';

import '../entities/current_user.dart';
import '../repositories/login_repository.dart';

class LoginUseCases {

  final LoginRepository loginRepository;

  LoginUseCases({required this.loginRepository});

  Future<Either<Failure, CurrentUser>> call(LoginParam loginParam) {
    return loginRepository.login(loginParam);
  }



  Future<Either<Failure, void>> cacheCurrentUser(CurrentUser currentUser) {
    return loginRepository.cacheCurrentUser(currentUser);
  }


  void logout() {
    loginRepository.logout();
  }

  Future<Either<Failure, CurrentUser>> getSavedCredentials() {
    return loginRepository.getSavedCredentials();
  }


  Future<Either<Failure, UserDetails>> getUserByEmail(String username) {
    return loginRepository.getUserByEmail(username);
  }


  Future<Either<Failure, void>> sendEmailToUSer(String username, email) {
    return loginRepository.sendEmailToUser(username, email);
  }

  Future<Either<Failure, UserDetails>> changePasswordByUsername(String username, newPassword) {
    return loginRepository.changePasswordByUsername(username, newPassword);

  }

}



class LoginParam extends Equatable {

  final String username;
  final String password;

  const LoginParam({required this.username, required this.password});

  @override
  List<Object?> get props => [];
}




