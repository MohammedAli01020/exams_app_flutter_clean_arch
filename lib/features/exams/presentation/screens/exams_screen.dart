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
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_edit_text.dart';
import '../../../login/presentation/cubit/login_cubit.dart';

class ExamsScreen extends StatefulWidget {
  const ExamsScreen({Key? key}) : super(key: key);

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  final _controller = ScrollController();

  var formKey = GlobalKey<FormState>();

  TextEditingController examTitleController = TextEditingController();

  void _getExams({required bool refresh}) {
    BlocProvider.of<ExamsCubit>(context)
        .getAllExams(ExamPageParam(pageSize: 15, refresh: refresh));
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
      listener: (context, state) {
        if (state is CreatingExamError) {
          Constants.showErrorDialog(context: context, msg: "CreatingExamError");
        }


        if (state is ExamDeletingError) {
          Constants.showErrorDialog(
              context: context, msg: "ExamDeletingError");
        }


      },
      builder: (context, state) {
        final examsCubit = ExamsCubit.get(context);

        if (state is LoadingRefreshExamsError) {
          return ErrorItemWidget(
            msg: state.msg,
            onPress: () {
              _getExams(refresh: true);
            },
          );
        }

        if (state is LoadingRefreshExams
            || state is CreatingExam) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        }

        if (state is LoadingRefreshExamsCompleted ||
            state is ExamCreated ||
            state is ExamDeleted) {
          if (examsCubit.exams.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "Empty, no exams added yest , you can start adding by clicking plus button",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
            );
          }
        }

        return Scrollbar(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _controller,
            itemBuilder: (context, index) {
              final currentExam = examsCubit.exams[index];

              return ExamListItem(
                exam: currentExam,
                onTap: () {
                  if (Constants.currentUser!.role == AppStrings.adminRole) {
                    Navigator.pushNamed(
                        context, Routes.examsQuestionsAdminRoute,
                        arguments: currentExam);
                  } else {
                    Navigator.pushNamed(
                        context, Routes.examsQuestionStudentRoute,
                        arguments: currentExam);
                  }
                }, examItemIndex: index, onDeleteButtonClicked: () {

                examsCubit.deleteExam(currentExam.examId, index);
              }, deletingItemIndex: examsCubit.currentDeletingExamItemIndex,
              );
            },
            itemCount: examsCubit.exams.length,
          ),
        );
      },
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (c) {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context)
                          .viewInsets
                          .bottom),
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
                              hint: "Exam title",
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return AppStrings.required;
                                }
                                return null;
                              },

                              controller: examTitleController,
                              inputType:
                              TextInputType.text),

                          const SizedBox(height: 16.0,),

                          Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: CustomButtonWidget(
                                  text: "Add",
                                  onPress: () {

                                    if (formKey.currentState!.validate()) {

                                      BlocProvider.of<ExamsCubit>(context).createExam(
                                          ExamParam(
                                              examTitle: examTitleController.text,
                                              questions: const [],
                                              userId: Constants.currentUser!.userId,
                                              creationDateTime: DateTime.now().millisecondsSinceEpoch));


                                      examTitleController.clear();
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
                                  text: "cancel",
                                  onPress: () {
                                    examTitleController.clear();
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
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.initialRoute, (route) => false);
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
    examTitleController.dispose();
  }
}
