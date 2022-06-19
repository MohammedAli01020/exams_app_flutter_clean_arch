import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/features/exams/domain/entities/user_exam.dart';
import 'package:exams_app/features/exams/domain/repositories/user_exam_repository.dart';

abstract class UserExamUserCases {
  Future<Either<Failure, List<UserExam>>> getUserExamByUserId(int userId);

  Future<Either<Failure,  List<UserExam>>> getAllUsersExam();

  Future<Either<Failure, UserExam>> addUserExam(UserExamParam userExamParam);
}



class UserExamUserCasesImpl implements UserExamUserCases {

  final UserExamRepository userExamRepository;

  UserExamUserCasesImpl({required this.userExamRepository});

  @override
  Future<Either<Failure, UserExam>> addUserExam( UserExamParam userExamParam) {
    return userExamRepository.addUserExam( userExamParam);
  }

  @override
  Future<Either<Failure, List<UserExam>>> getAllUsersExam() {
    return userExamRepository.getAllUsersExam();
  }

  @override
  Future<Either<Failure, List<UserExam>>> getUserExamByUserId(int userId) {
    return userExamRepository.getUserExamByUserId(userId);
  }




}

class UserExamParam extends Equatable {


  final int userId;
  final int examId;

  final int score;

  final int fullScore;

  final int correct;

  final int incorrect;

  final int notAttempted;

  final int submittedDate;

  const UserExamParam(
      {required this.userId,
      required this.examId,
      required this.score,
      required this.fullScore,
      required this.correct,
      required this.incorrect,
      required this.notAttempted,
      required this.submittedDate});

  @override
  List<Object?> get props => [
        userId,
        examId,
        score,
        fullScore,
        correct,
        incorrect,
        notAttempted,
        submittedDate
      ];
}
