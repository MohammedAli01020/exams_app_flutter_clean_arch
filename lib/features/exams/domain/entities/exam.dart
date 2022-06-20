import 'package:equatable/equatable.dart';

class Exam extends Equatable {
  const Exam({
    required this.examId,
    required this.examTitle,
    required this.creationDateTime,
    required this.userDetails,
  });

  final int examId;
  final String examTitle;
  final int creationDateTime;
  final UserDetails userDetails;

  @override
  List<Object?> get props => [
        examId,
        examTitle,
        creationDateTime,
        userDetails,
      ];
}

class UserDetails extends Equatable {
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


  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
      userId: json["userId"],
      username: json["username"],
      password: json["password"],
      age: json["age"],
      roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x)))

  );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "password": password,
        "age": age,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson()))
      };

  @override
  List<Object?> get props => [userId, username, password, age, roles];
}

class Role extends Equatable {
  const Role({
    required this.roleId,
    required this.appUserRole,
  });

  final int roleId;
  final String appUserRole;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleID"],
        appUserRole: json["appUserRole"],
      );

  Map<String, dynamic> toJson() => {
        "roleID": roleId,
        "appUserRole": appUserRole,
      };

  @override
  List<Object?> get props => [roleId, appUserRole];
}
