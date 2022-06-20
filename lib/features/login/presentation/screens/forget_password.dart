import 'dart:math';

import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/core/widgets/custom_button_widget.dart';
import 'package:exams_app/core/widgets/custom_edit_text.dart';
import 'package:exams_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var formKeyFirst = GlobalKey<FormState>();

  var formKeySecond = GlobalKey<FormState>();

  var formKeyThird = GlobalKey<FormState>();

  String? otp;

  TextEditingController usernameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();



  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset password")),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is GettingUserByEmailError) {
            Constants.showErrorDialog(
                context: context, msg: "GettingUserByEmailError");
          }


          if (state is SendingEmailToUserError) {
            Constants.showErrorDialog(
                context: context, msg: "SendingEmailToUserError");
          }

          if (state is CheckingOtpError) {
            Constants.showErrorDialog(
                context: context, msg: "CheckingOtpError");
          }


          if (state is UpdatingPasswordError) {
            Constants.showErrorDialog(
                context: context, msg: "UpdatingPasswordError");
          }

          if (state is SendingEmailToUserSuccess) {
            Constants.showToast(
                msg: "SendingEmailToUserSuccess", color: AppColors.green);
          }



        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);


          if (state is UpdatingPasswordSuccess) {

            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Success updating password", style: TextStyle(color: AppColors.primary),),
                  CustomButtonWidget(text: "Go to login", onPress: () {
                    Navigator.pop(context);
                  },)
                ],
              ),
            );
          }



          if (state is SendingEmailToUser || state is UpdatingPassword) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primary,
              ),
            );
          }



          return Stepper(
            currentStep: cubit.currentState,
            steps: [

              Step(
                  title: const Text("Enter your email "),
                  content: Form(
                    key: formKeyFirst,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomEditText(
                            hint: "email",
                            controller: usernameController,
                            inputType: TextInputType.emailAddress,

                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.required;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  )),
              Step(
                  title: const Text("Enter the otp code "),
                  content: Form(
                    key: formKeySecond,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomEditText(
                          hint: "Otp code",
                          controller: codeController,
                          inputType: TextInputType.number,
                          inputFormatter: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          maxLength: 4,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.required;
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  )),
              Step(
                  title: const Text("Enter the new password"),
                  content: Form(
                    key: formKeyThird,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomEditText(
                          hint: "New password",
                          controller: newPasswordController,
                          inputType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppStrings.required;
                            }
                            return null;
                          },

                        ),
                      ],
                    ),
                  )),

            ],
            onStepContinue: () {

              FocusScope.of(context).unfocus();

              if (cubit.currentState == 0) {

                if (formKeyFirst.currentState!.validate()) {
                  otp = (Random().nextInt(9000) + 1000).toString();
                  cubit.sendEmailToUser(usernameController.text.trim(),
                      "Your activation code to reset password is\n$otp");
                }
                return;
              }

              if (cubit.currentState == 1) {
                if (formKeySecond.currentState!.validate()) {
                  cubit.checkOtp(otp, codeController.text.trim());
                }
                return;
              }


              if (cubit.currentState == 2) {
                if (formKeyThird.currentState!.validate()) {
                  cubit.updatePasswordByUsername(usernameController.text.trim(),
                      newPasswordController.text);
                }

                return;
              }
            },
            onStepCancel: () {

              FocusScope.of(context).unfocus();

              if (cubit.currentState == 0) {
                Navigator.pop(context);
                return;
              }

              cubit.currentState --;
              setState(() {});
            },
          );
        },
      ),
    );
  }
}
