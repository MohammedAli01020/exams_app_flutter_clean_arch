import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/features/exams/domain/entities/exam.dart';
import 'package:flutter/material.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/constants.dart';
import 'defaut_deleting_widget.dart';

class ExamListItem extends StatelessWidget {
  final Exam exam;
  final int examItemIndex;
  final int deletingItemIndex;
  final Function onTap;
  // final VoidCallback onDeleteButtonClicked;

  const ExamListItem(
      {Key? key,
      required this.exam,
      required this.onTap,
      required this.examItemIndex,
      // required this.onDeleteButtonClicked,
      required this.deletingItemIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (examItemIndex == deletingItemIndex) {
      return const DefaultDeletingWidget();
    } else {
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
                  end: Alignment.bottomLeft)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      exam.examTitle.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),



                  // if (Constants.currentUser!.role == AppStrings.adminRole)
                  //   IconButton(
                  //       onPressed: onDeleteButtonClicked,
                  //       icon: const Icon(
                  //         Icons.delete,
                  //         color: Colors.white,
                  //       ))
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                AppLocalizations.of(context)!.translate('created_by')! + exam.userDetails.username,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Text(
                AppLocalizations.of(context)!.translate('created_at')! +
                    Constants.dateFromMilliSeconds(exam.creationDateTime),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
      );
    }
  }
}
