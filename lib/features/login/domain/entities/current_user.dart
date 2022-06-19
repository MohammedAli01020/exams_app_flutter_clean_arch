import 'package:equatable/equatable.dart';


class CurrentUser extends Equatable {

  const CurrentUser( {
    required this.role,
    required this.token,
    required this.username,
    required this.userId,
  });

  final  String role;
  final String token;
  final  String username;
  final int userId;

  @override
  List<Object?> get props =>
  [
   role,
   token,
   username,
   userId
  ];


}
