

import '../../../../core/error/failures.dart';

import 'package:dartz/dartz.dart';


import '../entities/question.dart';
import '../use_cases/question_use_cases.dart';


abstract class QuestionRepository {
  Future<Either<Failure, List<Question>>> getQuestionByExamId(int examId);
  Future<Either<Failure, void>> deleteQuestion(int questionId);
  Future<Either<Failure, Question>> addQuestion(int examId, QuestionParam questionParam);
}