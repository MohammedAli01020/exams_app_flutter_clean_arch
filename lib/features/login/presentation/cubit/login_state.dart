

part of 'login_cubit.dart';


@immutable
abstract class LoginState extends Equatable {

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginIsLoading extends LoginState {}


class LoginIsLoaded extends LoginState {

  final CurrentUser currentUser;

  LoginIsLoaded({required this.currentUser});

  @override
  List<Object?> get props => [currentUser];

}


class LoginError extends LoginState {
  final String msg;

  LoginError({required this.msg});


  @override
  List<Object?> get props => [msg];


}



class LoggingOut extends LoginState {

}


class LoggingOutComplete extends LoginState {

}


class StartGetSavedCredential extends LoginState {

}

class EndGetSavedCredential extends LoginState {
  final CurrentUser currentUser;

  EndGetSavedCredential({required this.currentUser}) {
    Constants.currentUser = currentUser;
  }


  @override
  List<Object?> get props => [currentUser];
}


class GetSavedCredentialError extends LoginState {
  final String msg;

  GetSavedCredentialError({required this.msg});


  @override
  List<Object?> get props => [msg];

}




class GettingUserByEmail extends LoginState {}


class GettingUserByEmailSuccess extends LoginState {}

class GettingUserByEmailError extends LoginState {
  final String msg;

  GettingUserByEmailError({required this.msg});


  @override
  List<Object?> get props => [msg];

}



class SendingEmailToUser extends LoginState {

}

class SendingEmailToUserSuccess extends LoginState {

}

class SendingEmailToUserError extends LoginState {
  final String msg;

  SendingEmailToUserError({required this.msg});


  @override
  List<Object?> get props => [msg];
}


class CheckingOtpSuccess extends LoginState {

}


class CheckingOtpError extends LoginState {
  final String msg;

  CheckingOtpError({required this.msg});


  @override
  List<Object?> get props => [msg];
}




class UpdatingPassword extends LoginState{}

class UpdatingPasswordError extends LoginState{
  final String msg;

  UpdatingPasswordError({required this.msg});


  @override
  List<Object?> get props => [msg];

}

class UpdatingPasswordSuccess extends LoginState{}