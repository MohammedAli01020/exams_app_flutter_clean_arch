import 'package:exams_app/features/exams/domain/entities/user_exam.dart';
import 'package:flutter/material.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/constants.dart';

class ExamResultListItem extends StatelessWidget {
  final UserExam currentUserExam;
  const ExamResultListItem({Key? key, required this.currentUserExam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Text(currentUserExam.exam.examTitle, style: const TextStyle(color: Colors.white)),
          const Divider(
            color: Colors.white,
          ),

          Text(AppLocalizations.of(context)!.translate('correct')! + currentUserExam.correct.toString(),
            style: TextStyle(color: AppColors.green),),
          Text(AppLocalizations.of(context)!.translate('incorrect')! +  currentUserExam.incorrect.toString(),
              style:  TextStyle(color: AppColors.red)
          ),

          Text(AppLocalizations.of(context)!.translate('score')! +  "${currentUserExam.correct} / ${currentUserExam.fullScore} ",
              style : const TextStyle(color: Colors.white)),


          const Divider(
            color: Colors.white,
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.translate('student')! + currentUserExam.userDetails.username.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 18.0),),

              Text(AppLocalizations.of(context)!.translate('teacher')! + currentUserExam.exam.userDetails.username.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 18.0),),
              Text(AppLocalizations.of(context)!.translate('submitted_at')!  + Constants.dateFromMilliSeconds(currentUserExam.submittedDate),
                  style: const TextStyle(color: Colors.white, fontSize: 18.0)),
            ],
          )



        ],
      ),
    );
  }
}
