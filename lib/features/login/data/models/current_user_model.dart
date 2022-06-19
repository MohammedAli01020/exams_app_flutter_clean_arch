

import '../../domain/entities/current_user.dart';

class CurrentUserModel extends CurrentUser {
  const CurrentUserModel(
      {required String role, required String token, required String username, required int userId})
      : super(role: role, token: token, username: username, userId: userId );

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      role: json["role"],
      token: json["token"],
      username: json["username"],
      userId: json["userId"],


    );
  }

  Map<String, dynamic> toJson() {
    return {
      "role": role,
      "token": token,
      "username": username,
      "userId": userId,

    };
  }
}
