import 'package:dartz/dartz.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/features/exams/data/data_sources/question_remote_data_source.dart';
import 'package:exams_app/features/exams/domain/entities/question.dart';
import 'package:exams_app/features/exams/domain/repositories/question_repository.dart';
import 'package:exams_app/features/exams/domain/use_cases/question_use_cases.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDataSource questionRemoteDataSource;
  final NetworkInfo networkInfo;

  QuestionRepositoryImpl(
      {required this.questionRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Question>> addQuestion(
      int examId, QuestionParam questionParam) async {
    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response =
          await questionRemoteDataSource.addQuestion(examId, questionParam);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteQuestion(int questionId) async {

    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response =
          await questionRemoteDataSource.deleteQuestion(questionId);

      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Question>>> getQuestionByExamId(
      int examId) async {
    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response =
          await questionRemoteDataSource.getQuestionByExamId(examId);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
