import 'package:dartz/dartz.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/features/exams/data/data_sources/exams_remote_data_scource.dart';
import 'package:exams_app/features/exams/domain/entities/exam.dart';
import 'package:exams_app/features/exams/domain/repositories/exams_repository.dart';
import 'package:exams_app/features/exams/domain/use_cases/exam_use_cases.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

class ExamsRepositoryImpl implements ExamsRepository {

  final ExamsRemoteDataSource examsRemoteDataSource;
  final NetworkInfo networkInfo;

  ExamsRepositoryImpl( {required this.examsRemoteDataSource,
    required this.networkInfo});

  @override
  Future<Either<Failure, void>> deleteExam(int examId) async {

    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response = await examsRemoteDataSource.deleteExam(examId);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Map>> getAllExam(ExamPageParam examPageParam,  int pageNumber) async {

    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response = await examsRemoteDataSource.getAllExams(examPageParam, pageNumber);

      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }

  }

  @override
  Future<Either<Failure, Exam>> createExam(ExamParam examParam) async {

    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }


    try {
      final response = await examsRemoteDataSource.createExam(examParam);

      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

}