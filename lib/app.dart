import 'package:exams_app/config/themes/app_theme.dart';
import 'package:flutter/material.dart';

import 'config/locale/app_localizations_setup.dart';
import 'config/routes/app_routes.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/login/presentation/cubit/lang/locale_cubit.dart';
import 'features/login/presentation/cubit/login_cubit.dart';
import 'injection_container.dart' as di;


class ExamsApp extends StatelessWidget {


  const ExamsApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
        di.sl<LoginCubit>()
          ..getSavedCredentials()),
        BlocProvider(create: (context) => di.sl<LocaleCubit>()..getSavedLang()),

      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(

        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },

        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            theme: appTheme(),
            locale: state.locale,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
            AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
            AppLocalizationsSetup.localizationsDelegates,


          );
        },
      ),
    );
  }


}