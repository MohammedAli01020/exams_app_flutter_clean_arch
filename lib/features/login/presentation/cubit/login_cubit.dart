import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/features/exams/data/models/user_exams_data.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/current_user.dart';
import '../../domain/use_cases/login_use_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCases loginUseCases;

  LoginCubit({required this.loginUseCases}) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);



  int currentState = 0;

  Future<void> login(LoginParam loginParam) async {

    emit(LoginIsLoading());

    Either<Failure, CurrentUser> response = await loginUseCases(loginParam);

    emit(response.fold((failure) => LoginError(msg: _mapFailureToMsg(failure)),
        (currentUser) => LoginIsLoaded(currentUser: currentUser)));
  }


  Future<void> getSavedCredentials() async {

    emit(StartGetSavedCredential());

    Either<Failure, CurrentUser> response = await loginUseCases.getSavedCredentials();

    emit(response.fold((failure) => GetSavedCredentialError(msg: _mapFailureToMsg(failure)),
            (currentUser) => EndGetSavedCredential(currentUser: currentUser)));

  }



  void checkOtp(String? currentOtp, String userOtp) {

    if (currentOtp != null && currentOtp.isNotEmpty ) {


      if (currentOtp == userOtp) {
        currentState ++;
        emit(CheckingOtpSuccess());

      } else {
        emit(CheckingOtpError(msg: "CheckingOtpError"));
      }

    } else {

      emit(CheckingOtpError(msg: "Otp is Empty or null"));
    }



  }

  Future<void> sendEmailToUser(String username, String email) async {


    emit(GettingUserByEmail());

    Either<Failure, UserDetails> response =
    await loginUseCases.getUserByEmail(username);

    if (response.isRight()) {
      emit(GettingUserByEmailSuccess());

      emit(SendingEmailToUser());

      Either<Failure, void> response2 =
      await loginUseCases.sendEmailToUSer(username, email);


      if (response2.isRight()) {
        debugPrint("is Right");
        currentState ++;
      }

      emit(response2.fold((failure) => SendingEmailToUserError(msg: _mapFailureToMsg(failure)),
              (success) => SendingEmailToUserSuccess()));

    } else {
      emit(GettingUserByEmailError(msg: "GettingUserByEmailError"));
    }


  }

  Future<void> updatePasswordByUsername(String username, String newPassword) async {

    emit(UpdatingPassword());
    Either<Failure, UserDetails> response =
        await loginUseCases.changePasswordByUsername(username, newPassword);


    emit(response.fold((l) => UpdatingPasswordError(msg: _mapFailureToMsg(l)),
            (r) => UpdatingPasswordSuccess()));

  }


  void logout() {
    emit(LoggingOut());
    loginUseCases.logout();
    emit(LoggingOutComplete());
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;

      default:
        return AppStrings.unexpectedError;
    }
  }
}
