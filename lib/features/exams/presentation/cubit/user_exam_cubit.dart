import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:exams_app/features/exams/domain/use_cases/user_exam_use_cases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/entities/user_exam.dart';
import 'package:equatable/equatable.dart';
part 'user_exam_state.dart';

class UserExamCubit extends Cubit<UserExamState> {
  final UserExamUserCases userExamUserCases;

  UserExamCubit({required this.userExamUserCases}) : super(UserExamInitial());

  Future<void> addUserExam(UserExamParam userExamParam) async {

    emit(CreatingUserExam());


    Either<Failure, UserExam> response =
        await userExamUserCases.addUserExam(userExamParam);

    emit(response.fold(
            (failure) => CreatingUserExamError(msg: _mapFailureToMsg(failure)),
            (userExam) => CreatingUserExamSuccess(userExam: userExam)));
  }


  Future<void> getAllExams() async {

    emit(LoadingUsersExam());

    Either<Failure, List<UserExam>> response =
    await userExamUserCases.getAllUsersExam();

    emit(response.fold(
            (failure) => LoadingUsersExamError(msg: _mapFailureToMsg(failure)),
            (userExamList) => LoadingUsersExamSuccess(usersExamList: userExamList )));

  }



  Future<void> getAllExamsByUserId(int userId) async {

    emit(LoadingUsersExam());

    Either<Failure, List<UserExam>> response =
    await userExamUserCases.getUserExamByUserId(userId);

    emit(response.fold(
            (failure) => LoadingUsersExamError(msg: _mapFailureToMsg(failure)),
            (userExamList) => LoadingUsersExamSuccess(usersExamList: userExamList )));

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


