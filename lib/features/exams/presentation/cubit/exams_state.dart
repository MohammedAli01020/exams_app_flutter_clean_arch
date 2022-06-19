part of 'exams_cubit.dart';

@immutable
abstract class ExamsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ExamsInitial extends ExamsState {

}

class CreatingExam extends ExamsState {}

class LoadingExams extends ExamsState {}

class LoadingRefreshExams extends ExamsState {}

class LoadNoMore extends ExamsState {}


class ExamsLoaded extends ExamsState {}

class ExamsLoadingError extends ExamsState {
  final String msg;

  ExamsLoadingError({required this.msg});


  @override
  List<Object?> get props => [msg];

}


class LoadingRefreshExamsError extends ExamsState {
  final String msg;

  LoadingRefreshExamsError({required this.msg});


  @override
  List<Object?> get props => [msg];
}

class LoadingRefreshExamsCompleted extends ExamsState {

}




class CreatingExamError extends ExamsState {
  final String msg;

  CreatingExamError({required this.msg});


  @override
  List<Object?> get props => [msg];

}

class ExamCreated extends ExamsState {


}

class ExamDeleting extends ExamsState {}
class ExamDeletingError extends ExamsState {
  final String msg;

  ExamDeletingError({required this.msg});


  @override
  List<Object?> get props => [msg];

}
class ExamDeleted extends ExamsState {}
