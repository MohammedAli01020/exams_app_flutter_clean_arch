import 'dart:convert';

import 'package:exams_app/core/error/exceptions.dart';
import 'package:exams_app/features/exams/data/models/user_exam_model.dart';
import 'package:exams_app/features/exams/data/models/user_exams_data.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../domain/use_cases/user_exam_use_cases.dart';

abstract class UserExamRemoteDataSource {
  Future<List<UserExamModel>> getUserExamByUserId(int userId);

  Future<List<UserExamModel>> getAllUsersExam();

  Future<UserExamModel> addUserExam( UserExamParam userExamParam);

  Future<UserExamModel> findUserExamByUserIdAndExamId(int userId, int examId);

}


class UserExamRemoteDataSourceImpl implements UserExamRemoteDataSource {


  final ApiConsumer apiConsumer;

  UserExamRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UserExamModel> addUserExam(UserExamParam userExamParam) async {

    try {

      final response = await apiConsumer
          .post(EndPoints.addUserExam, body: {
        "userId": userExamParam.userId,
        "examId": userExamParam.examId,
        "score": userExamParam.score,
        "fullScore": userExamParam.fullScore,

        "correct": userExamParam.correct,
        "incorrect": userExamParam.incorrect,
        "notAttempted": userExamParam.notAttempted,
        "submittedDate": userExamParam.submittedDate,

      });

      return UserExamModel.fromJson(response);
    } catch (e) {
      throw const ServerException();
    }

  }

  @override
  Future<List<UserExamModel>> getAllUsersExam() async {


    try {
      final response =
      await apiConsumer.get(EndPoints.allUserExam);


      return List<UserExamModel>.from(
          response.map((x) => UserExamModel.fromJson(x)));
    } catch (e) {
      throw const ServerException();
    }


  }

  @override
  Future<List<UserExamModel>> getUserExamByUserId(int userId) async {
    try {


      final response =
      await apiConsumer.get(EndPoints.allUserExamByUserId + userId.toString());


      return List<UserExamModel>.from(
          response.map((x) => UserExamModel.fromJson(x)));
    } catch (e) {
      throw const ServerException();
    }


  }

  @override
  Future<UserExamModel> findUserExamByUserIdAndExamId(int userId, int examId) async {


    try {
      final response =
          await apiConsumer.get(EndPoints.findUserExamByUserAndExam, queryParameters: {
            "userId": userId,
             "examId": examId
      });

      return UserExamModel.fromJson(response);

    } catch (e) {
      throw const ServerException();
    }
  }

}
