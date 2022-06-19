
import 'package:exams_app/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({Key? key, this.onPress, required this.text}) : super(key: key);
  final VoidCallback? onPress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: context.width * 0.55,
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: AppColors.primary,
            onPrimary: Theme.of(context).primaryColor,
            elevation: 500,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: Text(text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700),
        ),
        onPressed: () {
          if (onPress != null) {
            onPress!();
          }
        },
      ),
    );
  }
}
