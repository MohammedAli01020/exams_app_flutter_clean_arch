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
}


class UserExamRemoteDataSourceImpl implements UserExamRemoteDataSource {


  final ApiConsumer apiConsumer;

  UserExamRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<UserExamModel> addUserExam(UserExamParam userExamParam) async {
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
  }

  @override
  Future<List<UserExamModel>> getAllUsersExam() async {

    final response =
        await apiConsumer.get(EndPoints.allUserExam);


      return List<UserExamModel>.from(
          response.map((x) => UserExamModel.fromJson(x)));

  }

  @override
  Future<List<UserExamModel>> getUserExamByUserId(int userId) async {
    final response =
        await apiConsumer.get(EndPoints.allUserExamByUserId + userId.toString());


    return List<UserExamModel>.from(
        response.map((x) => UserExamModel.fromJson(x)));
  }

}
