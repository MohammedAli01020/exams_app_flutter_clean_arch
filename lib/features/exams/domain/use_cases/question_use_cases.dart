import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exams_app/core/error/failures.dart';
import 'package:exams_app/features/exams/domain/entities/question.dart';
import 'package:exams_app/features/exams/domain/repositories/question_repository.dart';



abstract class QuestionUseCases {
  Future<Either<Failure, List<Question>>> getQuestionByExamId(int examId);

  Future<Either<Failure, void>> deleteQuestion(int questionId);

  Future<Either<Failure, Question>> addQuestion(
      int examId, QuestionParam questionParam);
}

class QuestionUseCasesImpl implements QuestionUseCases {
  final QuestionRepository questionRepository;

  QuestionUseCasesImpl({required this.questionRepository});

  @override
  Future<Either<Failure, Question>> addQuestion(
      int examId, QuestionParam questionParam) {
    return questionRepository.addQuestion(examId, questionParam);
  }

  @override
  Future<Either<Failure, void>> deleteQuestion(int questionId) {
    return questionRepository.deleteQuestion(questionId);
  }

  @override
  Future<Either<Failure, List<Question>>> getQuestionByExamId(int examId) {
    return questionRepository.getQuestionByExamId(examId);
  }
}

class QuestionParam extends Equatable {
  final String title;
  final List<String> answers;

  final String correctAnswer;

  final int creationDateTime;

  const QuestionParam(
      {required this.title,
      required this.answers,
      required this.correctAnswer,
      required this.creationDateTime});

  @override
  List<Object?> get props => [title, answers, correctAnswer, creationDateTime];
}

