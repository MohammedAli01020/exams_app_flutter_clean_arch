// To parse this JSON data, do
//
//     final userExam = userExamFromJson(jsonString);


import 'package:exams_app/features/exams/data/models/exam_model.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_exams_data.dart';


class UserExam extends Equatable{
  const UserExam({
    required this.userExamId,
    required this.exam,
    required this.userDetails,
    required this.score,
    required this.fullScore,
    required this.correct,
    required this.incorrect,
    required this.notAttempted,
    required this.submittedDate,
  });

  final UserExamId userExamId;
  final ExamModel exam;
  final UserDetails userDetails;
  final int score;
  final int fullScore;
  final int correct;
  final int incorrect;
  final int notAttempted;
  final int submittedDate;


  @override
  List<Object?> get props => [
  userExamId,
   exam,
   userDetails,
   score,
   fullScore,
   correct,
   incorrect,
   notAttempted,
   submittedDate,


  ];
}


class UserDetails {
  UserDetails({
    required this.userId,
    required this.username,
    required this.password,
    required this.age,
    required this.roles,
  });

  int userId;
  String username;
  String password;
  int age;
  List<Role> roles;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    userId: json["userId"],
    username: json["username"],
    password: json["password"],
    age: json["age"],
    roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "password": password,
    "age": age,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
  };
}


class UserExamId {
  UserExamId({
    required this.userId,
    required this.examId,
  });

  int userId;
  int examId;

  factory UserExamId.fromJson(Map<String, dynamic> json) => UserExamId(
    userId: json["userId"],
    examId: json["examId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "examId": examId,
  };
}
