import 'package:exams_app/features/login/domain/entities/current_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'app_colors.dart';

class Constants {
  static void showErrorDialog(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(
                msg,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                      primary: Colors.black,
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  child: const Text('Ok'),
                )
              ],
            ));
  }

  static void showToast(
      {required String msg, Color? color, ToastGravity? gravity}) {

    Fluttertoast.cancel();

    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: msg,
        backgroundColor: color ?? AppColors.primary,
        gravity: gravity ?? ToastGravity.BOTTOM);
  }



  static String dateFromMilliSeconds(int dateMillis) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dateMillis);

    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(dateTime);

    return formattedDate;
  }

  static CurrentUser? currentUser;

}
