import 'package:exams_app/core/error/exceptions.dart';
import 'package:exams_app/features/exams/data/models/question_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../domain/use_cases/question_use_cases.dart';

abstract class QuestionRemoteDataSource {
  Future<List<QuestionModel>> getQuestionByExamId(int examId);

  Future<void> deleteQuestion(int questionId);

  Future<QuestionModel> addQuestion(int examId, QuestionParam questionParam);
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final ApiConsumer apiConsumer;

  QuestionRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<QuestionModel> addQuestion(
      int examId, QuestionParam questionParam) async {

    try {
      final response = await apiConsumer
          .post(EndPoints.addQuestion + examId.toString(), body: {
        "answers": questionParam.answers,
        "correctAnswer": questionParam.correctAnswer,
        "title": questionParam.title,
        "creationDateTime": questionParam.creationDateTime
      });

      return QuestionModel.fromJson(response);
    } catch (e) {
      throw const ServerException();
    }

  }

  @override
  Future<void> deleteQuestion(int questionId) async {


    try {
      final response = await apiConsumer.delete(EndPoints.deleteQuestion + questionId.toString());

      return response;
    } catch (e) {

      debugPrint(e.toString());

    }



  }

  @override
  Future<List<QuestionModel>> getQuestionByExamId(int examId) async {

    try {
      final response = await apiConsumer
          .get(EndPoints.allQuestion, queryParameters: {"examId": examId});

      return List<QuestionModel>.from(
          response.map((x) => QuestionModel.fromJson(x)));
    } catch (e) {
      throw const ServerException();
    }


  }
}
