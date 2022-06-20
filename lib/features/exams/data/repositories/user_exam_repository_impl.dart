import 'package:dartz/dartz.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/features/exams/data/data_sources/user_exam_remote_data_source.dart';
import 'package:exams_app/features/exams/domain/entities/user_exam.dart';
import 'package:exams_app/features/exams/domain/repositories/user_exam_repository.dart';
import 'package:exams_app/features/exams/domain/use_cases/user_exam_use_cases.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';

class UserExamRepositoryImpl implements UserExamRepository {
  final UserExamRemoteDataSource userExamRemoteDataSource;
  final NetworkInfo networkInfo;

  UserExamRepositoryImpl(
      {required this.userExamRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserExam>> addUserExam(
      UserExamParam userExamParam) async {
    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response =
          await userExamRemoteDataSource.addUserExam(userExamParam);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserExam>>> getAllUsersExam() async {
    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response = await userExamRemoteDataSource.getAllUsersExam();
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserExam>>> getUserExamByUserId(
      int userId) async {
    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response =
          await userExamRemoteDataSource.getUserExamByUserId(userId);

      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserExam>> getUserExamByUserIdAndExamId(
      int userId, int examId) async {
    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response = await userExamRemoteDataSource
          .findUserExamByUserIdAndExamId(userId, examId);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
