import 'package:exams_app/features/exams/domain/entities/exam.dart';
import 'package:exams_app/features/exams/domain/use_cases/question_use_cases.dart';
import 'package:exams_app/features/exams/presentation/cubit/question_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/error_item_widget.dart';

class ExamQuestionsAdminScreen extends StatefulWidget {
  final Exam exam;

  const ExamQuestionsAdminScreen({Key? key, required this.exam})
      : super(key: key);

  @override
  State<ExamQuestionsAdminScreen> createState() =>
      ExamQuestionsAdminScreenState();
}

class ExamQuestionsAdminScreenState extends State<ExamQuestionsAdminScreen> {


  void _loadQuestion() {
    BlocProvider.of<QuestionCubit>(context).getAllQuestionsByExamId(
        widget.exam.examId);
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
              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  "Empty, no questions added yest , you can start adding by clicking plus button",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: AppColors.primary),
                )),
              );
            }
          }

          return ListView.builder(

            itemBuilder: (context, index) {
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
                            fontWeight: FontWeight.bold, fontSize: 18.0, color: AppColors.primary),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(cubit.questions[index].answers.toString(), style: TextStyle(color: AppColors.primary, fontSize: 18.0),),

                      const SizedBox(
                        height: 16.0,
                      ),

                      Row(
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            const TextSpan(
                                text: 'The correct choice ',
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: cubit.questions[index].correctAnswer,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.green)),
                          ])),
                          const Spacer(),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.more)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: cubit.questions.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<QuestionCubit>(context).addQuestionToExam(
              widget.exam.examId,
              QuestionParam(
                  answers: const ["A. Mido", "B. Ali", "C. Ahmed", "D. Wael"],
                  correctAnswer: "B. Ali",
                  title: 'what is your name ?',
                  creationDateTime: DateTime.now().millisecondsSinceEpoch));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
