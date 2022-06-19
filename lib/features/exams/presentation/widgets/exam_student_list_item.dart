import 'package:exams_app/features/exams/domain/entities/question.dart';
import 'package:flutter/material.dart';

class ExamStudentListItem extends StatefulWidget {
  final Question question;
  final int index;

  const ExamStudentListItem({Key? key, required this.question, required this.index}) : super(key: key);

  @override
  State<ExamStudentListItem> createState() => _ExamStudentListItemState();
}

class _ExamStudentListItemState extends State<ExamStudentListItem> {

  bool isAnswered = false;
  bool? isCorrectAnswer;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (widget.index + 1).toString()  + ". " + widget.question.title.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18.0, color: isAnswered ? Colors.green: Colors.black),
            ),

            const SizedBox(
              height: 16.0,
            ),

          ],
        ),
      ),
    );
  }
}



