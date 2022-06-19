import 'package:exams_app/core/error/failures.dart';

import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:exams_app/features/exams/data/models/user_exams_data.dart';

import '../entities/current_user.dart';
import '../repositories/login_repository.dart';

class LoginUseCases {

  final LoginRepository loginRepository;

  LoginUseCases({required this.loginRepository});

  Future<Either<Failure, CurrentUser>> call(LoginParam loginParam) {
    return loginRepository.login(loginParam);
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
}



class LoginParam extends Equatable {

  final String username;
  final String password;

  const LoginParam({required this.username, required this.password});

  @override
  List<Object?> get props => [];
}




