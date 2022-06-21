
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
          InkWell(

          // .split("@")[0]

            child: UserAccountsDrawerHeader(
                accountName:
            Text("role: " +  Constants.currentUser!.role.toString(), style: const TextStyle(fontSize: 20.0)),
                accountEmail: Text(Constants.currentUser!.username, style: const TextStyle(fontSize: 20.0),)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.profileRoute, arguments: Constants.currentUser!.userId);
            },
          ),


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
