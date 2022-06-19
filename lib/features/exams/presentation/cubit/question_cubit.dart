import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exams_app/core/error/exceptions.dart';
import 'package:exams_app/features/exams/domain/entities/question.dart';
import 'package:exams_app/features/exams/domain/entities/quiz_state.dart';
import 'package:exams_app/features/exams/domain/use_cases/question_use_cases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final QuestionUseCases questionUseCases;


  List<Question> questions = [];

  QuestionCubit({required this.questionUseCases}) : super(QuestionInitial());

  static QuestionCubit get(context) => BlocProvider.of(context);

  Future<void> addQuestionToExam(
      int examId, QuestionParam questionParam) async {
    emit(QuestionCreating());


    Either<Failure, Question> response =
        await questionUseCases.addQuestion(examId, questionParam);

    if (response.isRight()) {
      questions.add(response.getOrElse(() => throw const ServerException()));
    }

    emit(response.fold(
        (failure) => QuestionCreatingError(msg: _mapFailureToMsg(failure)),
        (question) => QuestionCreatingSuccess()));
  }

  Future<void> getAllQuestionsByExamId(
      int examId) async {


    emit(LoadingQuestions());

    Either<Failure, List<Question>> response =
        await questionUseCases.getQuestionByExamId(examId);

    if (response.isRight()) {
      questions = response.getOrElse(() => throw const ServerException());
    }

    emit(response.fold(
        (failure) => LoadingQuestionsError(msg: _mapFailureToMsg(failure)),
        (questionsData) => LoadingQuestionsSuccess()));
  }


  QuizState quizState = QuizState.initial();

  void submitAnswer(Question currentQuestion, String answer) {
    if (quizState.answered) return;

    emit(StartAnswering());

    if (currentQuestion.correctAnswer == answer) {
      quizState = quizState.copyWith(
        selectedAnswer: answer,
        correct: List.from(quizState.correct)..add(currentQuestion),
        status: QuizStatus.correct,
        incorrect: quizState.incorrect,
      );
    } else {
      quizState = quizState.copyWith(
        selectedAnswer: answer,
        incorrect: List.from(quizState.incorrect)..add(currentQuestion),
        status: QuizStatus.incorrect,
        correct: quizState.correct,
      );
    }



    emit(EndAnswering());
  }

  void nextQuestion(List<Question> questions, int currentIndex) {

    emit(StartNextQuestion());

    quizState = quizState.copyWith(
      selectedAnswer: '',
      status: currentIndex + 1 < questions.length
          ? QuizStatus.initial
          : QuizStatus.complete,
      incorrect: quizState.incorrect,
      correct: quizState.correct,
    );

    emit(EndNextQuestion());

  }


  void reset() {

    emit(StartReset());

    quizState = QuizState.initial();

    emit(EndReset());

  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;

      default:
        return AppStrings.unexpectedError;
    }
  }
}
