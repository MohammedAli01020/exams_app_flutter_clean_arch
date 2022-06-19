import 'package:exams_app/config/routes/app_routes.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName:
          Text(Constants.currentUser!.username.toString().split("@")[0]),
              accountEmail: Text(Constants.currentUser!.username)),


          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.examsResultsRoute);
            },
            title: const Text(
              "exams results",
            ),
            leading: const Icon(Icons.edit),
          ),

        ],
      ),
    );
  }
}
