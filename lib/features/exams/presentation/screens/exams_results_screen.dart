import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/features/exams/presentation/cubit/user_exam_cubit.dart';
import 'package:exams_app/features/exams/presentation/widgets/default_empty_widget.dart';
import 'package:exams_app/features/exams/presentation/widgets/exam_result_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/error_item_widget.dart';

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
        title: Text(Constants.currentUser!.role == AppStrings.adminRole ?
        AppLocalizations.of(context)!.translate('my_exams_results')! :
        AppLocalizations.of(context)!.translate('students_exams_results')!),
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
              msg: state.msg,
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


            if (state.usersExamList.isEmpty) {
              return const DefaultEmptyWidget(msg: "Empty, you did not solve any exams yet!");
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {

              final currentUserExam =  state.usersExamList[index];
              return ExamResultListItem(currentUserExam: currentUserExam,);

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
