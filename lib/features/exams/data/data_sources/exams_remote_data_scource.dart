import 'package:exams_app/core/error/exceptions.dart';
import 'package:exams_app/features/exams/data/models/exam_model.dart';
import 'package:exams_app/features/exams/domain/use_cases/exam_use_cases.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';


abstract class ExamsRemoteDataSource {
  Future<Map> getAllExams(ExamPageParam examPageParam, int pageNumber);

  Future<void> deleteExam(int examId);

  Future<ExamModel> createExam(ExamParam examParam);
}

class ExamsRemoteDataSourceImpl implements ExamsRemoteDataSource {
  final ApiConsumer apiConsumer;


  ExamsRemoteDataSourceImpl(
      {required this.apiConsumer});

  @override
  Future<void> deleteExam(int examId) async {

    try {
      final response =
      await apiConsumer.delete(EndPoints.deleteExam + examId.toString());

      return response;

    } catch (e) {
      debugPrint(e.toString());
    }


  }

  @override
  Future<Map> getAllExams(ExamPageParam examPageParam, int pageNumber) async {


    try {
      final response =
      await apiConsumer.get(EndPoints.getAllExams, queryParameters: {
        "pageNumber": pageNumber,
        "pageSize": examPageParam.pageSize
      });

      return response;
    } catch (e) {
      throw const ServerException();
    }

  }

  @override
  Future<ExamModel> createExam(ExamParam examParam) async {


    try {
      final response = await apiConsumer.post(EndPoints.createExam, body: {
        "examTitle": examParam.examTitle,
        "questions": examParam.questions,
        "userId": examParam.userId,
        "creationDateTime": examParam.creationDateTime
      });

      return  ExamModel.fromJson(response);
    } catch (e) {
      throw const ServerException();

    }

  }
}
