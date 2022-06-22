import 'package:exams_app/config/routes/app_routes.dart';

import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/core/widgets/custom_edit_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../domain/use_cases/login_use_cases.dart';
import '../cubit/lang/locale_cubit.dart';
import '../cubit/login_cubit.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isVisible = false;


  Widget _buildBodyContent() {

    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {

        if (state is LoginIsLoaded) {
          Constants.showToast(msg: "logged in success");
        }


        if (state is LoginError) {
          Constants.showErrorDialog(context: context,
              msg: state.msg);
        }


        if (state is LoginIsLoaded) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.examsRoute, (route) => false);
        }


      },

      builder: (context, state) {

        if (state is LoginIsLoading || state is StartGetSavedCredential) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        }

        return Form(
          key: formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomEditText(
                      hint: AppLocalizations.of(context)!.translate('email')!,
                      prefixIcon :  Icon(Icons.email_outlined, color: AppColors.primary,),
                      suffixIcon: usernameController.text.isEmpty
                          ? null
                          : IconButton(
                          onPressed: () {
                            usernameController.clear();
                          },
                          icon:  Icon(Icons.clear, color: AppColors.primary)),
                      controller: usernameController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return AppLocalizations.of(context)!.translate('required')!;
                        }

                        return null;
                      }, inputType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 16.0,),
                    CustomEditText(
                      hint: AppLocalizations.of(context)!.translate('password')!,

                      prefixIcon: Icon(Icons.lock_outline, color: AppColors.primary,),
                      suffixIcon: IconButton(
                          onPressed: () {

                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: isVisible
                              ?  Icon(Icons.visibility_off_outlined, color: AppColors.primary)
                              :  Icon(Icons.visibility_outlined, color: AppColors.primary)),
                      isPassword: !isVisible,
                      controller: passwordController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return AppLocalizations.of(context)!.translate('required')!;
                        }

                        return null;
                      }, inputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 16.0,),
                    CustomButtonWidget(
                      text: AppLocalizations.of(context)!.translate('login')!,
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context).login(
                              LoginParam(
                                  username: usernameController.text.trim(),
                                  password: passwordController.text));
                        }
                      },
                    ),

                    const SizedBox(height: 16.0,),
                    TextButton(onPressed: () {

                      Navigator.pushNamed(context, Routes.forgetPasswordRoute);

                    }, child: Text(AppLocalizations.of(context)!.translate('forget_password')!, style: const TextStyle(fontSize: 18.0),))


                  ],
                ),
              ),
            ),
          ),
        );

      },
    );
  }


  @override
  void initState() {
    super.initState();

    usernameController.addListener(() {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(

            children: [
              TextSpan(
                text: "Quiz",
                style: TextStyle(color: AppColors.primary, fontSize: 30.0, fontWeight: FontWeight.bold),
              ),

              TextSpan(
                text: "App",
                style: TextStyle(color: AppColors.hint, fontSize: 30.0),
              ),


            ]
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.translate_outlined,
              color: AppColors.primary,
            ),
            onPressed: () {
              if (AppLocalizations.of(context)!.isEnLocale) {
                BlocProvider.of<LocaleCubit>(context).toArabic();
              } else {
                BlocProvider.of<LocaleCubit>(context).toEnglish();
              }
            },
          ),
        ],

      ),
      body: _buildBodyContent()
    );
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
}
