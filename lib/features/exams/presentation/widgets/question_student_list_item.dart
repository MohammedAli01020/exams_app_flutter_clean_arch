import 'package:exams_app/features/exams/domain/entities/question.dart';
import 'package:exams_app/features/exams/domain/entities/quiz_state.dart';

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'answer_card.dart';

class QuestionStudentListItem extends StatelessWidget {
  final Question currentQuestion;
  final QuizState quizState;
  final Function onTap;
  const QuestionStudentListItem({Key? key,required this.currentQuestion,
    required this.quizState, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              currentQuestion.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: AppColors.primary),
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            Column(
              children: currentQuestion.answers.map((e) {
                return AnswerCard(
                    answer: e,
                    isSelected:
                    e == quizState.selectedAnswer,
                    isCorrect:
                    e == currentQuestion.correctAnswer,
                    isDisplayingAnswer:
                    quizState.answered,
                    onTap: () {
                      onTap(e);
                    }
                );
              }).toList(),
            ),
            Text(currentQuestion.answers.toString()),
            Text(currentQuestion.correctAnswer.toString()),
          ],
        ),
      ),
    );
  }
}
