import 'package:exams_app/config/routes/app_routes.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exams_app/core/utils/app_strings.dart';

import '../../config/locale/app_localizations.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          InkWell(

            // .split("@")[0]

            child: UserAccountsDrawerHeader(
                accountName:
                Text(AppLocalizations.of(context)!.translate('role')! + Constants.currentUser!.role.toString(),
                    style: const TextStyle(fontSize: 20.0)),
                accountEmail: Text(Constants.currentUser!.username,
                  style: const TextStyle(fontSize: 20.0),)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.profileRoute,
                  arguments: Constants.currentUser!.userId);
            },
          ),


          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.examsResultsRoute);
            },
            title: Text(
              Constants.currentUser!.role == AppStrings.adminRole ?
              AppLocalizations.of(context)!.translate('students_exams_results')! :
              AppLocalizations.of(context)!.translate('my_exams_results')!
            ),
            leading: const Icon(Icons.edit),
          ),

          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoggingOutComplete) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.initialRoute, (route) => false);
              }

            },
            builder: (context, state) {
              return ListTile(
                onTap: () {
                  Navigator.pop(context);
                  BlocProvider.of<LoginCubit>(context).logout();
                },
                title: Text(
                  AppLocalizations.of(context)!.translate('logout')!,
                ),
                leading: const Icon(Icons.logout),
              );
            },
          ),

        ],
      ),
    );
  }
}
