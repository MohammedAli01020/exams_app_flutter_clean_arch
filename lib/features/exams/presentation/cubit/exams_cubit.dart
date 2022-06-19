import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exams_app/core/error/exceptions.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/features/exams/data/models/exams_data.dart';
import 'package:exams_app/features/exams/domain/entities/exam.dart';
import 'package:exams_app/features/exams/domain/use_cases/exam_use_cases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/app_strings.dart';

part 'exams_state.dart';

class ExamsCubit extends Cubit<ExamsState> {
  final ExamUseCases examUseCases;

  List<Exam> exams = [];
  int examsCurrentPage = 0;
  int examsTotalElements = 0;
  late int examsPagesCount;

  ExamsCubit({required this.examUseCases}) : super(ExamsInitial());

  static ExamsCubit get(context) => BlocProvider.of(context);
  Future<void> getAllExams(ExamPageParam examPageParam) async {

    if (examPageParam.refresh) {
      examsCurrentPage = 0;
      emit(LoadingRefreshExams());
    } else {
      if (examsCurrentPage >= examsPagesCount) {
        emit(LoadNoMore());
        return;
      } else {
        emit(LoadingExams());
      }
    }



    Either<Failure, Map> response =
        await examUseCases.getAllExam(examPageParam, examsCurrentPage);

    if (response.isRight()) {

      String res = jsonEncode(response.getOrElse(() => {}));
      final result = examsDataFromJson(res);
      setExamsData(result, examPageParam.refresh);
    }

    if (examPageParam.refresh) {
      emit(response.fold(
          (failure) => LoadingRefreshExamsError(msg: _mapFailureToMsg(failure)),
          (map) => LoadingRefreshExamsCompleted()));
    } else {
      emit(response.fold(
          (failure) => ExamsLoadingError(msg: _mapFailureToMsg(failure)),
          (map) => ExamsLoaded()));
    }
  }

  Future<void> createExam(ExamParam examParam) async {
    emit(CreatingExam());

    Either<Failure, Exam> response = await examUseCases.createExam(examParam);

    if (response is! Failure) {
      Exam exam = response.getOrElse(() {
        throw const ServerException();
      });

      exams.add(exam);
    }

    emit(response.fold(
        (failure) => CreatingExamError(msg: _mapFailureToMsg(failure)),
        (exam) => ExamCreated()));
  }

  Future<void> deleteExam(int examId) async {
    emit(ExamDeleting());

    Either<Failure, void> response = await examUseCases.deleteExam(examId);

    if (response is! Failure) {
      try {
        exams.removeWhere((element) {
          return element.examId == examId;
        });
      } catch (e) {
        throw Exception();
      }
    }

    emit(response.fold(
        (failure) => ExamDeletingError(msg: _mapFailureToMsg(failure)),
        (deleted) => ExamDeleted()));
  }

  void setExamsData(ExamsData result, bool refresh) {
    List<Exam> newUsers = result.content;

    examsCurrentPage++;
    examsTotalElements = result.totalElements;
    examsPagesCount = result.totalPages;

    if (refresh) {
      exams = newUsers;
    } else {
      exams.addAll(newUsers);
    }
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
