
import 'dart:convert';
import 'dart:math';

import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/exams/data/models/user_exams_data.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../domain/use_cases/login_use_cases.dart';
import '../models/current_user_model.dart';


abstract class LoginRemoteDataSource {
  Future<CurrentUserModel> login(LoginParam loginParam);

  Future<void> sendEmailToUser(String username, String email);

  Future<UserDetailsModel> getUserByEmail(String username);

  Future<UserDetailsModel> changePasswordByUsername(String username, String newPassword);

}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  
  final ApiConsumer apiConsumer;

  LoginRemoteDataSourceImpl(
      {
    required this.apiConsumer,});

  
  @override
  Future<CurrentUserModel> login(LoginParam loginParam) async {


    final response = await apiConsumer.post(EndPoints.login,

    body: {
      AppStrings.username: loginParam.username,
      AppStrings.password: loginParam.password
    });


    return  CurrentUserModel.fromJson(response);
  }

  @override
  Future<void> sendEmailToUser(String username, String email) async {


    try {

      final response = await apiConsumer.get(EndPoints.sendEmail,

          queryParameters: {
            "to": username,
            "email": email
          });

      return response;
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  @override
  Future<UserDetailsModel> getUserByEmail(String username) async {

    try {

      final response = await apiConsumer.get(EndPoints.findUserByEmail + username);

      return UserDetailsModel.fromJson(response);
    } catch (e) {
      debugPrint(e.toString());
      throw ServerFailure();

    }

  }

  @override
  Future<UserDetailsModel> changePasswordByUsername(String username, String newPassword) async {

    try {
      final response = await apiConsumer.put(EndPoints.updatePasswordByUsername + username,
      queryParameters: {
        "newPassword": newPassword
      });
      return UserDetailsModel.fromJson(response);

    } catch (e) {
      debugPrint(e.toString());
      throw ServerFailure();
    }
  }

  
}






