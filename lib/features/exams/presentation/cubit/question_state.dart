part of 'question_cubit.dart';


@immutable
abstract class QuestionState extends Equatable {
  @override
  List<Object?> get props => [];

}

class QuestionInitial extends QuestionState {}

class QuestionCreating extends QuestionState {}

class QuestionCreatingError extends QuestionState {
  final String msg;

  QuestionCreatingError({required this.msg});


  @override
  List<Object?> get props => [msg];
}

class QuestionCreatingSuccess extends QuestionState {}


class LoadingQuestions extends QuestionState {}

class LoadingQuestionsSuccess extends QuestionState {}

class LoadingQuestionsError extends QuestionState {
  final String msg;

  LoadingQuestionsError({required this.msg});

  @override
  List<Object?> get props => [msg];

}

class StartAnswering extends QuestionState {}

class EndAnswering extends QuestionState {}

class StartNextQuestion extends QuestionState {}

class EndNextQuestion extends QuestionState {}


class StartReset extends QuestionState {}

class EndReset extends QuestionState {}

