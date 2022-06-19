

import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_button_widget.dart';

class ErrorItemWidget extends StatelessWidget {
  final VoidCallback? onPress;
  const ErrorItemWidget({Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: AppColors.primary,
            size: 150,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: const Text(
            "something went wrong",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          "try again",
          style: TextStyle(
              color: AppColors.hint, fontSize: 18, fontWeight: FontWeight.w500),
        ),


        CustomButtonWidget(onPress: onPress, text: 'reload screen',)

      ],
    );
  }
}




