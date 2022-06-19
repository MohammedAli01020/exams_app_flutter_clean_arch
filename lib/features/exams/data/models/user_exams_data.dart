// To parse this JSON data, do
//
//     final userExam = userExamFromJson(jsonString);

import 'dart:convert';

import 'package:exams_app/features/exams/data/models/user_exam_model.dart';

List<UserExamModel> userExamFromJson(String str) => List<UserExamModel>.from(json.decode(str).map((x) => UserExamModel.fromJson(x)));

String userExamToJson(List<UserExamModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Exam {
  Exam({
    required  this.examId,
    required  this.examTitle,
    required  this.creationDateTime,
    required  this.userDetails,
  });

  int examId;
  String examTitle;
  int creationDateTime;
  UserDetails userDetails;

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    examId: json["examId"],
    examTitle: json["examTitle"],
    creationDateTime: json["creationDateTime"],
    userDetails: UserDetails.fromJson(json["userDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "examId": examId,
    "examTitle": examTitle,
    "creationDateTime": creationDateTime,
    "userDetails": userDetails.toJson(),
  };
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

class Role {
  Role({
    required this.roleId,
    required this.appUserRole,
  });

  int roleId;
  String appUserRole;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    roleId: json["roleID"],
    appUserRole: json["appUserRole"],
  );

  Map<String, dynamic> toJson() => {
    "roleID": roleId,
    "appUserRole": appUserRole,
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
