import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';


import '../entities/user_exam.dart';
import '../use_cases/user_exam_use_cases.dart';

abstract class UserExamRepository {

  Future<Either<Failure, List<UserExam>>> getUserExamByUserId(int userId);

  Future<Either<Failure,  List<UserExam>>> getAllUsersExam();

  Future<Either<Failure, UserExam>> addUserExam(
     UserExamParam userExamParam);
}