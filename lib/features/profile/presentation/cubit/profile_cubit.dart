
import 'package:exams_app/core/error/exceptions.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/features/exams/data/models/user_exams_data.dart';
import 'package:exams_app/features/login/domain/use_cases/login_use_cases.dart';
import 'package:exams_app/features/profile/domain/use_cases/profile_use_cases.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {

  final ProfileUseCases profileUseCases;
  final LoginUseCases loginUseCases;

  ProfileCubit( {
    required this.profileUseCases,
    required this.loginUseCases}) : super(ProfileInitial());


  UserDetails? userDetails;

  static ProfileCubit get(context) => BlocProvider.of(context);

  Future<void> getProfileData(int userId) async {

    emit(GettingProfileData());

    Either<Failure, UserDetails> response = await profileUseCases.getUserById(userId);


    if (response.isRight()) {
      userDetails = response.getOrElse(() => throw  const ServerException());
    }

    emit(response.fold((l) => GettingProfileDataError(msg: _mapFailureToMsg(l)),
            (r) => GettingProfileDataSuccess()));
  }




  Future<void> updateUsername(int userId, String newUsername) async {

    emit(UpdatingUsername());

    Either<Failure, UserDetails> response = await profileUseCases.changeUsername(userId, newUsername);


    if (response.isRight()) {
      userDetails = response.getOrElse(() => throw  const ServerException());


      Constants.currentUser = Constants.currentUser!.copyWith(
        username: newUsername
      );


      debugPrint( "newUsername: " + Constants.currentUser!.username.toString());

      loginUseCases.cacheCurrentUser(Constants.currentUser!);
    }

    emit(response.fold((l) => UpdatingUsernameError(msg: _mapFailureToMsg(l)),
            (r) => UpdatingUsernameSuccess()));



  }


  Future<void> updatePassword(int userId, String newPassword) async {

    emit(UpdatingPassword());

    Either<Failure, UserDetails> response = await profileUseCases.changePassword(userId, newPassword);


    if (response.isRight()) {
      userDetails = response.getOrElse(() => throw  const ServerException());
    }

    emit(response.fold((l) => UpdatingPasswordError(msg: _mapFailureToMsg(l)),
            (r) => UpdatingPasswordSuccess()));


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
