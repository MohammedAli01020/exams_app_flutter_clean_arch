import 'package:exams_app/config/routes/app_routes.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/core/widgets/custom_drawer.dart';
import 'package:exams_app/core/widgets/error_item_widget.dart';
import 'package:exams_app/features/exams/domain/use_cases/exam_use_cases.dart';
import 'package:exams_app/features/exams/presentation/cubit/exams_cubit.dart';
import 'package:exams_app/features/exams/presentation/widgets/exam_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../login/presentation/cubit/login_cubit.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  final _controller = ScrollController();

  void _getExams({required bool refresh}) {
    BlocProvider.of<ExamsCubit>(context).getAllExams(ExamPageParam(
        pageSize: 15,
        refresh: refresh));
  }

  @override
  void initState() {
    super.initState();
    _getExams(refresh: true);

    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _getExams(refresh: false);
      }
    });
  }

  Widget _buildBodyContent() {
    return BlocConsumer<ExamsCubit, ExamsState>(
      listener: (context, state) {},
      builder: (context, state) {
        final examsCubit = ExamsCubit.get(context);

        if (state is LoadingRefreshExamsError) {

          return ErrorItemWidget(
            onPress: () {
              _getExams(refresh: true);
            },
          );
        }

        if (state is LoadingRefreshExams) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        }

        if (state is LoadingRefreshExamsCompleted ) {
          if (examsCubit.exams.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: Text("Empty, no exams added yest , you can start adding by clicking plus button",
                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),)),
            );
          }

        }

        return ListView.builder(
          controller: _controller,
          itemBuilder: (context, index) {
            final currentExam = examsCubit.exams[index];

            return ExamListItem(
              exam: currentExam,
              onTap: () {
                if (Constants.currentUser!.role == AppStrings.adminRole) {
                  Navigator.pushNamed(context, Routes.examsQuestionsAdminRoute,
                      arguments: currentExam);
                } else {
                  Navigator.pushNamed(
                      context, Routes.examsQuestionStudentRoute, arguments: currentExam );
                }
              },
            );
          },
          itemCount: examsCubit.exams.length,
        );
      },
    );
  }

  Widget _buildFAB() {
    return BlocBuilder<ExamsCubit, ExamsState>(
      builder: (context, state) {
        final cubit = ExamsCubit.get(context);

        return FloatingActionButton(
          onPressed: () {
            cubit.createExam(ExamParam(
                examTitle: "Arabic Exam",
                questions: const [],
                userId: Constants.currentUser!.userId,
                creationDateTime: DateTime.now().millisecondsSinceEpoch));
          },
          child: state is CreatingExam
              ? const Text("...")
              : const Icon(Icons.add),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exams"),
        actions: [
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoggingOutComplete) {
                Navigator.pushNamedAndRemoveUntil(context, Routes.initialRoute, (route) => false);
              }
            },
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    BlocProvider.of<LoginCubit>(context).logout();
                  },
                  icon: const Icon(Icons.logout));
            },
          )
        ],
      ),
      body: _buildBodyContent(),
      floatingActionButton: Constants.currentUser!.role == AppStrings.adminRole
          ? _buildFAB()
          : null,
      
      drawer: const CustomDrawer(),
    );


  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
