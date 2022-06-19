import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomEditText extends StatelessWidget {
   const CustomEditText({Key? key,
    required this.hint, required this.controller, this.validator,
     this.isPassword = false, this.prefixIcon, this.suffixIcon, required this.inputType, this.inputFormatter,
     this.maxLength, this.autoFocus = false}) : super(key: key);

  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPassword;
 final Widget? prefixIcon;
  final  Widget? suffixIcon;
   final TextInputType inputType;
   final List<TextInputFormatter>? inputFormatter;
   final int? maxLength;
   final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      style: const TextStyle(
        fontSize: 20.0
      ),
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon
      ),

      validator: validator,
      obscureText: isPassword,
      inputFormatters: inputFormatter ?? [],
      maxLength: maxLength,

      autofocus: autoFocus,
    );
  }
}