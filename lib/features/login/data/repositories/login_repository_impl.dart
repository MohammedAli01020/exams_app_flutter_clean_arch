import 'package:dartz/dartz.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/core/network/network_info.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/features/exams/data/models/user_exams_data.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/current_user.dart';
import '../../domain/repositories/login_repository.dart';
import '../../domain/use_cases/login_use_cases.dart';
import '../data_sources/login_local_data_scource.dart';
import '../data_sources/login_remote_data_scource.dart';
import '../models/current_user_model.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginLocalDataSource localDataSource;
  final LoginRemoteDataSource loginRemoteDataSource;
  final NetworkInfo networkInfo;

  LoginRepositoryImpl(
      {required this.localDataSource, required this.loginRemoteDataSource, required this.networkInfo, });

  @override
  Future<Either<Failure, CurrentUser>> login(LoginParam loginParam) async {
    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final currentUserModel = await loginRemoteDataSource.login(loginParam);
      localDataSource.cacheCurrentUser(currentUserModel);
      Constants.currentUser = currentUserModel;

      return Right(currentUserModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  void logout() {
    localDataSource.removeCacheCurrentUser();
    Constants.currentUser = null;
  }

  @override
  Future<Either<Failure, CurrentUser>> getSavedCredentials() async {

    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      
      CurrentUserModel currentUserModel = await localDataSource.getCurrentUser();

      return Right(currentUserModel);
    } on CacheException {
      return Left(CacheFailure());
    }
    
  }

  @override
  Future<Either<Failure, void>> sendEmailToUser(String username, String email) async {


    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response = await loginRemoteDataSource.sendEmailToUser(username, email);

      return Right(response);

    } on ServerException {

      debugPrint("failure  here");
      return Left(ServerFailure());
    } catch (e) {

      debugPrint(e.toString());

      return Left(ServerFailure());
    }


  }

  @override
  Future<Either<Failure, UserDetails>> getUserByEmail(String username) async {

    if (!await networkInfo.isConnected()) {
      return Left(ServerFailure());
    }

    try {
      final response = await loginRemoteDataSource.getUserByEmail(username);

      return Right(response);

    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
