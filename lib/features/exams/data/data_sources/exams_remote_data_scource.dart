import 'package:exams_app/core/network/network_info.dart';
import 'package:exams_app/features/exams/data/models/exam_model.dart';
import 'package:exams_app/features/exams/domain/use_cases/exam_use_cases.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';

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

    final response =
    await apiConsumer.delete(EndPoints.getAllExams + examId.toString());

    return response;
  }

  @override
  Future<Map> getAllExams(ExamPageParam examPageParam, int pageNumber) async {

    final response =
        await apiConsumer.get(EndPoints.getAllExams, queryParameters: {
      "pageNumber": pageNumber,
      "pageSize": examPageParam.pageSize
    });

    return response;
  }

  @override
  Future<ExamModel> createExam(ExamParam examParam) async {


    final response = await apiConsumer.post(EndPoints.createExam, body: {
      "examTitle": examParam.examTitle,
      "questions": examParam.questions,
      "userId": examParam.userId,
      "creationDateTime": examParam.creationDateTime
    });

    return  ExamModel.fromJson(response);
  }
}
