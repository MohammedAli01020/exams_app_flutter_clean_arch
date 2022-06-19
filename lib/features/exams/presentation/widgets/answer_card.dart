import 'package:exams_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'circular_icon.dart';

class AnswerCard extends StatefulWidget {

  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  const AnswerCard({
    Key? key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isDisplayingAnswer,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AnswerCard> createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: widget.isDisplayingAnswer
                ? widget.isCorrect
                ? Colors.green
                : widget.isSelected
                ? Colors.red
                : AppColors.hint
                : AppColors.hint,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.answer,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: widget.isDisplayingAnswer && widget.isCorrect
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
            ),
            if (widget.isDisplayingAnswer)
              widget.isCorrect
                  ?  const CircularIcon(icon: Icons.check, color: Colors.green,)
                  : widget.isSelected
                  ?  const CircularIcon(
                icon: Icons.close,
                color: Colors.red,
              )
                  : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}