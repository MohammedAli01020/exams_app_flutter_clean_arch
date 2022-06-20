import 'package:dartz/dartz.dart';
import 'package:exams_app/core/error/exceptions.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/core/network/network_info.dart';
import 'package:exams_app/features/exams/data/models/user_exams_data.dart';
import 'package:exams_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:exams_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl(
      {required this.profileRemoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, UserDetails>> changePassword(int userId, String newPassword) async {
    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response = await profileRemoteDataSource.changePassword(userId, newPassword);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserDetails>> changeUsername(int userId, String newUsername) async {
    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response = await profileRemoteDataSource.changeUsername(userId, newUsername);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserDetails>> getUserById(int userId) async {
    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response = await profileRemoteDataSource.getUserById(userId);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
