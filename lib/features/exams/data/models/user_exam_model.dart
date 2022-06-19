import 'package:exams_app/features/exams/data/models/exam_model.dart';
import 'package:exams_app/features/exams/domain/entities/user_exam.dart';

class UserExamModel extends UserExam {
  const UserExamModel(
      {required UserExamId userExamId,
      required ExamModel exam,
      required UserDetails userDetails,
      required int score,
      required int fullScore,
      required int correct,
      required int incorrect,
      required int notAttempted,
      required int submittedDate})
      : super(
            userExamId: userExamId,
            exam: exam,
            userDetails: userDetails,
            score: score,
            fullScore: fullScore,
            correct: correct,
            incorrect: incorrect,
            notAttempted: notAttempted,
            submittedDate: submittedDate);

  factory UserExamModel.fromJson(Map<String, dynamic> json) => UserExamModel(
        userExamId: UserExamId.fromJson(json["userExamId"]),
        exam: ExamModel.fromJson(json["exam"]),
        userDetails: UserDetails.fromJson(json["userDetails"]),
        score: json["score"],
        fullScore: json["fullScore"],
        correct: json["correct"],
        incorrect: json["incorrect"],
        notAttempted: json["notAttempted"],
        submittedDate: json["submittedDate"],
      );

  Map<String, dynamic> toJson() => {
        "userExamId": userExamId.toJson(),
        "exam": exam.toJson(),
        "userDetails": userDetails.toJson(),
        "score": score,
        "fullScore": fullScore,
        "correct": correct,
        "incorrect": incorrect,
        "notAttempted": notAttempted,
        "submittedDate": submittedDate,
      };
}



