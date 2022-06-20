// To parse this JSON data, do
//
//     final userExam = userExamFromJson(jsonString);

import 'package:equatable/equatable.dart';
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
  UserDetailsModel userDetails;

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
    examId: json["examId"],
    examTitle: json["examTitle"],
    creationDateTime: json["creationDateTime"],
    userDetails: UserDetailsModel.fromJson(json["userDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "examId": examId,
    "examTitle": examTitle,
    "creationDateTime": creationDateTime,
    "userDetails": userDetails.toJson(),
  };
}

class UserDetails extends Equatable{
  const UserDetails({
    required this.userId,
    required this.username,
    required this.password,
    required this.age,
    required this.roles,
  });

  final int userId;
  final String username;
  final String password;
  final int age;
  final List<Role> roles;



  @override
  List<Object?> get props => [
  userId,
   username,
   password,
   age,
  roles


  ];
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


class UserDetailsModel extends UserDetails {

  const UserDetailsModel({required int userId, required String username, required String password, required int age, required List<Role> roles}) : super(userId: userId, username: username, password: password, age: age, roles: roles);


  factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
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
