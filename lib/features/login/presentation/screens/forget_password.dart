import 'dart:math';

import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/core/widgets/custom_button_widget.dart';
import 'package:exams_app/core/widgets/custom_edit_text.dart';
import 'package:exams_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var formKeyFirst = GlobalKey<FormState>();

  var formKeySecond = GlobalKey<FormState>();

  var formKeyThird = GlobalKey<FormState>();

  String? opt;

  TextEditingController usernameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Reset password")
      ),

      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is GettingUserByEmailError) {
            Constants.showErrorDialog(context: context, msg: "GettingUserByEmailError");
          }


          if (state is SendingEmailToUserError) {
            Constants.showErrorDialog(context: context, msg: "SendingEmailToUserError");
          }

          if (state is CheckingOtpError) {
            Constants.showErrorDialog(context: context, msg: "CheckingOtpError");
          }


        },
        builder: (context, state) {

          final cubit = LoginCubit.get(context);



          if (state is GettingUserByEmail || state is SendingEmailToUser) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (state is CheckingOtpSuccess) {

            return const Text("CheckingOtpSuccess", style: TextStyle(color: Colors.black),);

          }


          if (state is SendingEmailToUserSuccess || state is CheckingOtpError) {

            return Form(
              key: formKeySecond,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16.0),
                    CustomEditText(hint: "enter the opt code ...",
                      controller: codeController,
                      inputType: TextInputType.number,
                      autoFocus: true,

                      maxLength: 4,
                      inputFormatter: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],

                      validator: (v) {

                        if (v!.isEmpty) {
                          return AppStrings.required;
                        }

                        return null;
                      },

                    ),

                    const SizedBox(height: 16.0,),


                    CustomButtonWidget(text: "ok", onPress: () {

                      if (formKeySecond.currentState!.validate()) {

                        debugPrint("ok ok ");
                        cubit.checkOtp(opt, codeController.text.trim());
                      }
                    }),
                  ],
                ),
              ),
            );
          }




          return Form(
            key: formKeyFirst,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 16.0),
                  CustomEditText(hint: "type your email ...",
                      controller: usernameController,
                      inputType: TextInputType.emailAddress,
                  validator: (v) {

                    if (v!.isEmpty) {
                      return AppStrings.required;
                    }

                    return null;
                  },

                  ),

                  const SizedBox(height: 16.0,),


                  CustomButtonWidget(text: "ok", onPress: () {

                    if (formKeyFirst.currentState!.validate()) {



                      opt = (Random().nextInt(9000) + 1000).toString();


                      cubit.sendEmailToUser(usernameController.text.trim(), "The opt to rest password is : $opt");

                    }
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
