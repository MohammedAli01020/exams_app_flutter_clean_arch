part of 'profile_cubit.dart';

@immutable
abstract class ProfileState extends  Equatable  {

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}


class GettingProfileData extends ProfileState {}

class GettingProfileDataError extends ProfileState {
  final String msg;

  GettingProfileDataError({required this.msg});


  @override
  List<Object?> get props => [msg];
}

class GettingProfileDataSuccess extends ProfileState{}


class UpdatingUsername extends ProfileState{}

class UpdatingUsernameError extends ProfileState{
  final String msg;

  UpdatingUsernameError({required this.msg});


  @override
  List<Object?> get props => [msg];

}

class UpdatingUsernameSuccess extends ProfileState{}



class UpdatingPassword extends ProfileState{}

class UpdatingPasswordError extends ProfileState{
  final String msg;

  UpdatingPasswordError({required this.msg});


  @override
  List<Object?> get props => [msg];

}

class UpdatingPasswordSuccess extends ProfileState{}