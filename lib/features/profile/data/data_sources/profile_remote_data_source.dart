import 'package:exams_app/core/api/api_consumer.dart';
import 'package:exams_app/core/api/end_points.dart';
import 'package:exams_app/core/error/exceptions.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:flutter/cupertino.dart';

import '../../../exams/data/models/user_exams_data.dart';

abstract class ProfileRemoteDataSource {


  Future<UserDetailsModel> getUserById(int userId);

  Future<UserDetailsModel> changePassword(int userId, String newPassword);

  Future<UserDetailsModel> changeUsername(int userId, String newUsername);

}


class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {

  final ApiConsumer apiConsumer;

  ProfileRemoteDataSourceImpl({required this.apiConsumer});


  @override
  Future<UserDetailsModel> changePassword(int userId, String newPassword) async {

    try {
      final response = await apiConsumer.put(EndPoints.changePasswordById + userId.toString(),
      queryParameters: {
        "newPassword": newPassword
      });

      return UserDetailsModel.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw const ServerException();
    }

  }

  @override
  Future<UserDetailsModel> changeUsername(int userId, String newUsername) async {
    try {
      final response = await apiConsumer.put(EndPoints.changeUsernameById + userId.toString(),
      queryParameters: {
          "newUsername": newUsername
      });

      return UserDetailsModel.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw const ServerException();
    }
  }

  @override
  Future<UserDetailsModel> getUserById(int userId) async {
    try {
      final response = await apiConsumer.get(EndPoints.getUserById + userId.toString());

      return UserDetailsModel.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw const ServerException();
    }
  }

}