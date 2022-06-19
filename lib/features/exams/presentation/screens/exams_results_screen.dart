import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/core/widgets/custom_button_widget.dart';
import 'package:exams_app/features/exams/domain/use_cases/user_exam_use_cases.dart';
import 'package:exams_app/features/exams/presentation/cubit/question_cubit.dart';
import 'package:exams_app/features/exams/presentation/cubit/user_exam_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/error_item_widget.dart';
import '../../domain/entities/exam.dart';
import '../widgets/answer_card.dart';

class ExamsResultsScreen extends StatefulWidget {
  const ExamsResultsScreen({Key? key}) : super(key: key);

  @override
  State<ExamsResultsScreen> createState() => _ExamsResultsScreenState();
}

class _ExamsResultsScreenState extends State<ExamsResultsScreen> {


  void _loadAllUserExam() {
    BlocProvider.of<UserExamCubit>(context).getAllExams();
  }


  void _loadAllUserExamByUserId(int userId) {
    BlocProvider.of<UserExamCubit>(context).getAllExamsByUserId(userId);
  }


  @override
  void initState() {
    super.initState();


    if (Constants.currentUser!.role == AppStrings.adminRole) {
      _loadAllUserExam();
    } else {
      _loadAllUserExamByUserId(Constants.currentUser!.userId);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.currentUser!.role == AppStrings.adminRole ? "Students exam results" :"My exams results"),
      ),
      body: BlocConsumer<UserExamCubit, UserExamState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {

          if (state is LoadingUsersExam) {

             return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primary,
              ),
            );
          }


          if (state is LoadingUsersExamError) {
            return ErrorItemWidget(
              onPress: () {
                if (Constants.currentUser!.role == AppStrings.adminRole) {
                  _loadAllUserExam();
                } else {
                  _loadAllUserExamByUserId(Constants.currentUser!.userId);
                }
              },
            );
          }


          if (state is LoadingUsersExamSuccess) {
            return ListView.builder(itemBuilder: (context, index) {



              return Card(
                child: Column(

                  children: [

                    Text(state.usersExamList[index].exam.examTitle, style: const TextStyle(color: Colors.black)),

                    const Divider(),

                    Text("correct: " +state.usersExamList[index].correct.toString(),
                      style: TextStyle(color: AppColors.green),),
                    Text("incorrect: " + state.usersExamList[index].incorrect.toString(),
                        style: TextStyle(color: AppColors.red)
                    ),

                    Text("score: ${state.usersExamList[index].correct} / ${state.usersExamList[index].fullScore} ",
                         style : const TextStyle(color: Colors.black)),


                    const Divider(),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.usersExamList[index].userDetails.username.toString(),
                          style: const TextStyle(color: Colors.black, fontSize: 18.0),),



                        Text("teacher: " + state.usersExamList[index].exam.userDetails.username.toString(),
                          style: const TextStyle(color: Colors.black, fontSize: 18.0),),
                        Text("submitted at: " + Constants.dateFromMilliSeconds(state.usersExamList[index].submittedDate),
                            style: const TextStyle(color: Colors.black, fontSize: 18.0)),
                      ],
                    )



                  ],
                ),
              );


            },

            itemCount: state.usersExamList.length,);
          }



          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );



        },
      ),
    );
  }
}
