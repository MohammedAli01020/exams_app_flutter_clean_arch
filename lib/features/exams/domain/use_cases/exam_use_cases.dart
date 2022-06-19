
import 'package:dartz/dartz.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:exams_app/features/exams/domain/entities/exam.dart';

import '../repositories/exams_repository.dart';

abstract class ExamUseCases {


  Future<Either<Failure, Map>> getAllExam(ExamPageParam examPageParam, int pageNumber);
  Future<Either<Failure, void>> deleteExam(int examId);
  Future<Either<Failure, Exam>> createExam(ExamParam examParam);

}



class ExamsUserCasesImpl implements ExamUseCases {

  final ExamsRepository examsRepository;

  ExamsUserCasesImpl({required this.examsRepository});

  @override
  Future<Either<Failure, void>> deleteExam(int examId) {
    return examsRepository.deleteExam(examId);
  }

  @override
  Future<Either<Failure, Map>> getAllExam(ExamPageParam examPageParam, int pageNumber) {
    return examsRepository.getAllExam(examPageParam, pageNumber);
  }

  @override
  Future<Either<Failure, Exam>> createExam(ExamParam examParam) {

    return examsRepository.createExam(examParam);
  }

}


class ExamPageParam extends Equatable {


  final int pageSize;
  final bool refresh;

  const ExamPageParam( {
    required this.pageSize, required this.refresh,});

  @override
  List<Object?> get props =>
      [
        pageSize,
        refresh

      ];

}


class ExamParam extends Equatable {

  final String examTitle;
  final List<dynamic> questions;

  final int creationDateTime;
  final int userId;

  const ExamParam({required this.examTitle,
    required this.questions, required this.creationDateTime, required this.userId});



  @override
  List<Object?> get props =>
      [
        examTitle,
        questions,
        creationDateTime,
        userId
      ];

}
