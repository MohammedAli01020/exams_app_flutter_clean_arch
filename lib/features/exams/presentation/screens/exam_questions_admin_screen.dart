import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/features/exams/domain/entities/exam.dart';
import 'package:exams_app/features/exams/domain/use_cases/question_use_cases.dart';
import 'package:exams_app/features/exams/presentation/cubit/question_cubit.dart';
import 'package:exams_app/features/exams/presentation/widgets/default_empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_edit_text.dart';
import '../../../../core/widgets/error_item_widget.dart';
import '../widgets/defaut_deleting_widget.dart';

class ExamQuestionsAdminScreen extends StatefulWidget {
  final Exam exam;

  const ExamQuestionsAdminScreen({Key? key, required this.exam})
      : super(key: key);

  @override
  State<ExamQuestionsAdminScreen> createState() =>
      ExamQuestionsAdminScreenState();
}

class ExamQuestionsAdminScreenState extends State<ExamQuestionsAdminScreen> {

  var formKey = GlobalKey<FormState>();

  TextEditingController questionTitleController = TextEditingController();
  TextEditingController examTitleController = TextEditingController();
  TextEditingController choice1Controller = TextEditingController();
  TextEditingController choice2Controller = TextEditingController();
  TextEditingController choice3Controller = TextEditingController();
  TextEditingController choice4Controller = TextEditingController();
  TextEditingController choice5Controller = TextEditingController();
  TextEditingController choice6Controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    questionTitleController.dispose();
    examTitleController.dispose();
    choice1Controller.dispose();
    choice2Controller.dispose();
    choice3Controller.dispose();
    choice4Controller.dispose();
    choice5Controller.dispose();
    choice6Controller.dispose();
  }

  void _clearControllers() {
    questionTitleController.clear();
    examTitleController.clear();

    choice1Controller.clear();
    choice2Controller.clear();
    choice3Controller.clear();
    choice4Controller.clear();
    choice5Controller.clear();
    choice6Controller.clear();
  }

  void _loadQuestion() {
    BlocProvider.of<QuestionCubit>(context)
        .getAllQuestionsByExamId(widget.exam.examId);
  }

  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exam.examTitle.toString()),
      ),
      body: BlocConsumer<QuestionCubit, QuestionState>(
        listener: (context, state) {
          if (state is QuestionCreatingError) {
            Constants.showErrorDialog(
                context: context, msg: "QuestionCreatingError");
          }

          if (state is DeletingQuestionError) {
            Constants.showErrorDialog(
                context: context, msg: "DeletingQuestionError");
          }
        },
        builder: (context, state) {
          final cubit = QuestionCubit.get(context);

          if (state is LoadingQuestions || state is QuestionCreating) {
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

          if (cubit.questions.isEmpty) {
            return  DefaultEmptyWidget(
                msg: AppLocalizations.of(context)!.translate('empty_questions')!);
          } else {

            return ListView.builder(
              itemBuilder: (context, index) {
                if (index == cubit.deletingQuestionIndex) {
                  return const DefaultDeletingWidget();
                } else {
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.questions[index].title.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: AppColors.primary),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            cubit.questions[index].answers.toString(),
                            style: TextStyle(
                                color: AppColors.primary, fontSize: 18.0),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                    const TextSpan(
                                        text: "The correct choice: ",
                                        style: TextStyle(color: Colors.black)),
                                    TextSpan(
                                        text: cubit.questions[index].correctAnswer,
                                        style: const TextStyle(
                                            fontSize: 25.0,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.green)),
                                  ])),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    cubit.deleteQuestion(
                                        cubit.questions[index].questionId, index);
                                  },
                                  icon: const Icon(Icons.delete)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
              itemCount: cubit.questions.length,
            );
          }


        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (c) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    color: const Color(0xff757575),
                    child: Container(
                      padding: const EdgeInsets.all(25.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomEditText(
                                hint: AppLocalizations.of(context)!.translate('question_title')!,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return AppStrings.required;
                                  }
                                  return null;
                                },
                                controller: questionTitleController,
                                inputType: TextInputType.text),
                            const Divider(),
                            CustomEditText(
                                hint: AppLocalizations.of(context)!
                                    .translate('correct_choice')!,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return AppStrings.required;
                                  }
                                  return null;
                                },
                                controller: choice1Controller,
                                inputType: TextInputType.text),
                            CustomEditText(
                                hint: AppLocalizations.of(context)!
                                    .translate('choice_2')!,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return AppStrings.required;
                                  }
                                  return null;
                                },
                                controller: choice2Controller,
                                inputType: TextInputType.text),
                            CustomEditText(
                                hint: AppLocalizations.of(context)!
                                    .translate('choice_3')!,
                                controller: choice3Controller,
                                inputType: TextInputType.text),
                            CustomEditText(
                                hint: AppLocalizations.of(context)!
                                    .translate('choice_4')!,
                                controller: choice4Controller,
                                inputType: TextInputType.text),
                            CustomEditText(
                                hint: AppLocalizations.of(context)!
                                    .translate('choice_5')!,
                                controller: choice5Controller,
                                inputType: TextInputType.text),
                            CustomEditText(
                                hint: AppLocalizations.of(context)!
                                    .translate('choice_6')!,
                                controller: choice6Controller,
                                inputType: TextInputType.text),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: CustomButtonWidget(
                                    text: AppLocalizations.of(context)!
                                        .translate('add')!,
                                    onPress: () {
                                      if (formKey.currentState!.validate()) {
                                        List<String> choices = [
                                          choice1Controller.text,
                                          choice2Controller.text
                                        ];

                                        if (choice3Controller.text.isNotEmpty) {
                                          choices.add(choice3Controller.text);
                                        }

                                        if (choice4Controller.text.isNotEmpty) {
                                          choices.add(choice4Controller.text);
                                        }

                                        if (choice5Controller.text.isNotEmpty) {
                                          choices.add(choice5Controller.text);
                                        }

                                        if (choice6Controller.text.isNotEmpty) {
                                          choices.add(choice6Controller.text);
                                        }

                                        BlocProvider.of<QuestionCubit>(context)
                                            .addQuestionToExam(
                                                widget.exam.examId,
                                                QuestionParam(
                                                    answers: choices,
                                                    correctAnswer:
                                                        choice1Controller.text,
                                                    title:
                                                        questionTitleController
                                                            .text,
                                                    creationDateTime: DateTime
                                                            .now()
                                                        .millisecondsSinceEpoch));

                                        _clearControllers();
                                        Navigator.pop(context);
                                      }
                                    },
                                  ),
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: CustomButtonWidget(
                                    text: AppLocalizations.of(context)!
                                        .translate('cancel')!,
                                    onPress: () {
                                      _clearControllers();
                                      Navigator.pop(context);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
