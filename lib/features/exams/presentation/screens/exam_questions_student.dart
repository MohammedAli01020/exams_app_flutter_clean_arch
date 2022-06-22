import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/core/widgets/custom_button_widget.dart';
import 'package:exams_app/features/exams/domain/entities/quiz_state.dart';
import 'package:exams_app/features/exams/domain/use_cases/user_exam_use_cases.dart';
import 'package:exams_app/features/exams/presentation/cubit/question_cubit.dart';
import 'package:exams_app/features/exams/presentation/cubit/user_exam_cubit.dart';
import 'package:exams_app/features/exams/presentation/widgets/question_student_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/error_item_widget.dart';
import '../../domain/entities/exam.dart';
import '../widgets/default_empty_widget.dart';

class ExamsQuestionsStudentScreen extends StatefulWidget {
  final Exam exam;

  const ExamsQuestionsStudentScreen({Key? key, required this.exam})
      : super(key: key);

  @override
  State<ExamsQuestionsStudentScreen> createState() =>
      ExamsQuestionsStudentScreenState();
}

class ExamsQuestionsStudentScreenState
    extends State<ExamsQuestionsStudentScreen> {
  void _loadQuestion() {
    BlocProvider.of<QuestionCubit>(context).reset();

    BlocProvider.of<QuestionCubit>(context)
        .getAllQuestionsByExamId(widget.exam.examId);
  }

  void _loadUserExam(int userId, int examId) {
    BlocProvider.of<UserExamCubit>(context)
        .getUserExamByUserIdAndExamId(userId, examId);
  }

  @override
  void initState() {
    super.initState();
    _loadQuestion();
    _loadUserExam(Constants.currentUser!.userId, widget.exam.examId);
  }

  var boardController = PageController();
  bool isLast = false;
  bool completed = false;
  bool submitting = false;

  @override
  void dispose() {
    super.dispose();
    boardController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exam.examTitle.toString()),
      ),
      body: BlocConsumer<QuestionCubit, QuestionState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = QuestionCubit.get(context);

          if (state is LoadingQuestions) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primary,
              ),
            );
          }

          if (state is LoadingQuestionsError) {
            return ErrorItemWidget(
              msg: state.msg,
              onPress: () {
                _loadQuestion();
              },
            );
          }

          if (state is LoadingQuestionsSuccess) {
            if (cubit.questions.isEmpty) {
              return const DefaultEmptyWidget(msg: "Empty, no questions added yest , you can start adding by clicking plus button",);
            }
          }

          if (submitting) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primary,
              ),
            );
          } else if (completed) {
            return ExamCompletedWidget(
                quizState: cubit.quizState,
                questionLength: cubit.questions.length);
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UserExamCubit, UserExamState>(
                  builder: (context, state) {
                    if (state is LoadingUserExamByUserAndExam) {
                      return const LinearProgressIndicator();
                    }

                    if (state is LoadingUserExamByUserAndExamSuccess) {
                      return Container(
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(20.0),
                          color: AppColors.red,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Flexible(
                                child: Text(
                                  AppLocalizations.of(context)!.translate('solved_before')! + "( ${state.userExam.correct} / ${state.userExam.fullScore} )",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )),
                          ],
                        ),
                      );
                    }

                    if (state is LoadingUserExamByUserAndExamError) {
                      return const SizedBox(height: 0.0, width: 0.0);
                    }

                    return const LinearProgressIndicator();
                  },
                ),


                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: boardController,
                    itemBuilder: (context, index) {
                      final currentQuestion = cubit.questions[index];

                      return QuestionStudentListItem(
                          currentQuestion: currentQuestion,
                          quizState: cubit.quizState,
                          onTap: (e) {
                            cubit.submitAnswer(currentQuestion, e);
                          });
                    },
                    onPageChanged: (value) {
                      if (value == cubit.questions.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    itemCount: cubit.questions.length,
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    onPressed: () async {
                      if (isLast) {
                        setState(() {
                          submitting = true;
                        });

                        await BlocProvider.of<UserExamCubit>(context)
                            .addUserExam(UserExamParam(
                          userId: Constants.currentUser!.userId,
                          examId: widget.exam.examId,
                          score: cubit.quizState.correct.length,
                          fullScore: cubit.questions.length,
                          correct: cubit.quizState.correct.length,
                          incorrect: cubit.quizState.incorrect.length,
                          notAttempted: cubit.questions.length -
                              (cubit.quizState.correct.length +
                                  cubit.quizState.incorrect.length),
                          submittedDate: DateTime.now().millisecondsSinceEpoch,
                        ));

                        setState(() {
                          submitting = false;
                          completed = true;
                        });
                      } else {
                        boardController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);

                        cubit.nextQuestion(
                            cubit.questions, boardController.page!.toInt());
                      }
                    },
                    child: Icon(isLast ? Icons.done : Icons.arrow_forward_ios),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class ExamCompletedWidget extends StatelessWidget {
  final QuizState quizState;
  final int questionLength;

  const ExamCompletedWidget(
      {Key? key, required this.quizState, required this.questionLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
          AppLocalizations.of(context)!.translate('score')! + "${quizState.correct.length.toString()} / ${questionLength.toString()}",
            style: TextStyle(fontSize: 25.0, color: AppColors.primary),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            AppLocalizations.of(context)!.translate('correct')! + "${quizState.correct.length}",
            style: TextStyle(color: AppColors.green),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(AppLocalizations.of(context)!.translate('incorrect')! +  "${quizState.incorrect.length}",
              style: TextStyle(color: AppColors.red)),
          const SizedBox(
            height: 16.0,
          ),
          Text(
              AppLocalizations.of(context)!.translate('not_answered')! + "${(questionLength - (quizState.correct.length + quizState.incorrect.length))}",
              style: TextStyle(color: AppColors.hint)),
          const SizedBox(
            height: 16.0,
          ),
          CustomButtonWidget(
            text: AppLocalizations.of(context)!.translate('go_to_home')!,
            onPress: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}




