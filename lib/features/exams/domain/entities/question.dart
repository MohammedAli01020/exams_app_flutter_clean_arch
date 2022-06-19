import 'package:equatable/equatable.dart';
class Question extends Equatable {
   const Question({
    required this.questionId,
    required this.title,
    required this.answers,
    required this.creationDateTime,
    required this.correctAnswer,
  });

  final int questionId;
  final String title;
  final List<String> answers;
  final String correctAnswer;
  final int creationDateTime;


  @override
  List<Object?> get props => [
    questionId,
    title,
    answers,
    creationDateTime,
    correctAnswer
  ];
}