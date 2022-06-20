part of 'user_exam_cubit.dart';

@immutable
abstract class UserExamState extends Equatable{

  @override
  List<Object?> get props => [];
}

class UserExamInitial extends UserExamState {}


class CreatingUserExam extends UserExamState{}

class CreatingUserExamSuccess extends UserExamState{

  final UserExam userExam;

  CreatingUserExamSuccess({required this.userExam});

  @override
  List<Object?> get props => [userExam];


}

class CreatingUserExamError extends UserExamState{
  final String msg;

  CreatingUserExamError({required this.msg});


  @override
  List<Object?> get props => [msg];

}


class LoadingUsersExam extends UserExamState{}

class LoadingUsersExamSuccess extends UserExamState {
  final List<UserExam> usersExamList;

  LoadingUsersExamSuccess({required this.usersExamList}) {
    debugPrint("users exam length:" + usersExamList.length.toString());
  }

  @override
  List<Object?> get props => [usersExamList];

}

class LoadingUsersExamError extends UserExamState {
  final String msg;

  LoadingUsersExamError({required this.msg});


  @override
  List<Object?> get props => [msg];

}



class LoadingUserExamByUserAndExam extends UserExamState{}

class LoadingUserExamByUserAndExamSuccess extends UserExamState {
  final UserExam userExam;

  LoadingUserExamByUserAndExamSuccess({required this.userExam});

  @override
  List<Object?> get props => [userExam];

}

class LoadingUserExamByUserAndExamError extends UserExamState {
  final String msg;

  LoadingUserExamByUserAndExamError({required this.msg});


  @override
  List<Object?> get props => [msg];

}