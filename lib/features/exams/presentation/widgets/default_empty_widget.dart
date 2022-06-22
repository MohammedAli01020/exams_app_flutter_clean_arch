

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class DefaultEmptyWidget extends StatelessWidget {
  final String msg;
  const DefaultEmptyWidget({
    Key? key, required this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Text(msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: AppColors.primary),
          )),
    );
  }
}