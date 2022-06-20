import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/features/exams/domain/entities/exam.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class ExamListItem extends StatelessWidget {
  final Exam exam;
  final Function onTap;
  const ExamListItem({Key? key, required this.exam, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        padding: const EdgeInsets.all(8.0),

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(
            colors: [AppColors.hint, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exam.examTitle.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 16.0,),
            Text("created by: " + exam.userDetails.username,
              style: const TextStyle(color: Colors.white, fontSize: 16),),
            const SizedBox(height: 16.0,),
            Text("created at: " +
                Constants.dateFromMilliSeconds(
                    exam.creationDateTime), style:const TextStyle(color: Colors.white, fontSize: 16),)
          ],
        ),
      ),
    );

    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exam.examTitle.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 16.0,),
              Text("teacher name: " + exam.userDetails.username, style: TextStyle(color: AppColors.primary, fontSize: 16.0),),
              const SizedBox(height: 16.0,),
              Text("created at: " +
                  Constants.dateFromMilliSeconds(
                      exam.creationDateTime), style: TextStyle(color: AppColors.hint, fontSize: 16),)
            ],
          ),
        ),
      ),
    );


  }
}
