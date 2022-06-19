
import 'package:exams_app/features/exams/domain/entities/exam.dart';

import '../../../../core/error/failures.dart';
import '../use_cases/exam_use_cases.dart';
import 'package:dartz/dartz.dart';

abstract class ExamsRepository {
  Future<Either<Failure, Map>> getAllExam(ExamPageParam examPageParam, int pageNumber);

  Future<Either<Failure, void>> deleteExam(int examId);

  Future<Either<Failure, Exam>> createExam(ExamParam examParam);

}

