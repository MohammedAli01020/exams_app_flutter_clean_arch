import 'package:exams_app/features/exams/presentation/screens/exam_questions_admin_screen.dart';
import 'package:exams_app/features/exams/presentation/screens/exam_questions_student.dart';
import 'package:exams_app/features/exams/presentation/screens/exams_results_screen.dart';
import 'package:exams_app/features/exams/presentation/screens/exams_screen.dart';
import 'package:exams_app/features/login/presentation/screens/forget_password.dart';
import 'package:exams_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:exams_app/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/exams/domain/entities/exam.dart';
import '../../features/exams/presentation/cubit/exams_cubit.dart';
import '../../features/exams/presentation/cubit/question_cubit.dart';
import '../../features/exams/presentation/cubit/user_exam_cubit.dart';
import '../../features/login/presentation/cubit/login_cubit.dart';
import '../../features/login/presentation/screens/login_screen.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';

class Routes {
  static const String initialRoute = '/';
  static const String examsRoute = '/examsRoute';
  static const String examsQuestionsAdminRoute = '/examsQuestionAdminRoute';
  static const String examsQuestionStudentRoute = '/examsQuestionStudentRoute';

  static const String examsResultsRoute = '/examsResultsRoute';

  static const String forgetPasswordRoute = '/forgetPasswordRoute';

  static const String profileRoute = '/profileRoute';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is EndGetSavedCredential) {
                return BlocProvider(
                    create: (BuildContext context) {
                      return di.sl<ExamsCubit>();
                    },
                    child: const ExamsScreen());
              } else {
                return const LoginScreen();
              }
            },
          );
        }));

      case Routes.examsRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
              create: (BuildContext context) {
                return di.sl<ExamsCubit>();
              },
              child: const ExamsScreen());
        }));

      case Routes.examsQuestionsAdminRoute:
        final exam = routeSettings.arguments as Exam;

        return MaterialPageRoute(builder: ((context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => di.sl<QuestionCubit>()),
              BlocProvider(create: (context) => di.sl<UserExamCubit>()),
            ],
            child: ExamQuestionsAdminScreen(
              exam: exam,
            ),
          );
        }));

      case Routes.examsQuestionStudentRoute:
        return MaterialPageRoute(builder: ((context) {
          final exam = routeSettings.arguments as Exam;

          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => di.sl<QuestionCubit>()),
              BlocProvider(create: (context) => di.sl<UserExamCubit>()),
            ],
            child: ExamsQuestionsStudentScreen(
              exam: exam,
            ),
          );
        }));

      case Routes.examsResultsRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
              create: (BuildContext context) {
                return di.sl<UserExamCubit>();
              },
              child: const ExamsResultsScreen());
        }));

      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider(
              create: (BuildContext context) {
                return di.sl<LoginCubit>();
              },
              child: const ForgetPassword());
        }));

      case Routes.profileRoute:
        return MaterialPageRoute(
          builder: (context) {
            final userId = routeSettings.arguments as int;

            return BlocProvider(
                create: (BuildContext context) {
                  return di.sl<ProfileCubit>();
                },
                child: ProfileScreen(userId: userId));
          },
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text("AppStrings.noRouteFound"),
              ),
            )));
  }
}
