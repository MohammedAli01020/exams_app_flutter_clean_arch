import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/constants.dart';
import 'package:exams_app/core/utils/media_query_values.dart';
import 'package:exams_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/widgets/error_item_widget.dart';
import '../widgets/profile_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKeyFirst = GlobalKey<FormState>();
  var formKeySecond = GlobalKey<FormState>();

  void _getUserProfile(int userId) {
    BlocProvider.of<ProfileCubit>(context).getProfileData(userId);
  }

  void _updateUsername(int userId, String newUsername) {
    BlocProvider.of<ProfileCubit>(context).updateUsername(userId, newUsername);
  }

  void _updatePassword(int userId, String newPassword) {
    BlocProvider.of<ProfileCubit>(context).updatePassword(userId, newPassword);
  }

  @override
  void initState() {
    super.initState();
    _getUserProfile(widget.userId);
  }


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('profile')!),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdatingUsernameSuccess) {
            Constants.showToast(
                msg: "UpdatingUsernameSuccess", color: AppColors.green);
          }

          if (state is UpdatingPasswordSuccess) {
            Constants.showToast(
                msg: "UpdatingPasswordSuccess", color: AppColors.green);
          }
        },
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);

          if (state is GettingProfileData || state is UpdatingUsername) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primary,
              ),
            );
          }

          if (state is GettingProfileDataError) {
            return ErrorItemWidget(
              msg: state.msg,
              onPress: () {
                _getUserProfile(widget.userId);
              },
            );
          }

          if (state is UpdatingUsernameError) {
            return ErrorItemWidget(
              msg: state.msg,
              onPress: () {
                _updateUsername(widget.userId, emailController.text.trim());
              },
            );
          }

          if (state is UpdatingPasswordError) {
            return ErrorItemWidget(
              msg: state.msg,
              onPress: () {
                _updatePassword(widget.userId, passwordController.text.trim());
              },
            );
          }

          if (state is GettingProfileDataSuccess ||
              state is UpdatingUsernameSuccess ||
              state is UpdatingPasswordSuccess) {
            return ListView(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: context.width,
                      height: 180.0,
                      color: AppColors.primary,
                    ),
                    Positioned(
                      top: 180 - 50,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5.0, color: AppColors.primary)
                            ]),
                        child: CircleAvatar(
                          radius: 52.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 50.0,
                            child: ClipOval(
                                child: Image.network(
                              "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png",
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 100.0,
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {

                            return ProfileBottomSheet(
                              onUpdatePressedCallback: () {

                                if (formKeyFirst.currentState!.validate()) {

                                  _updatePassword(
                                      widget.userId,
                                      passwordController.text
                                          .trim());
                                  Navigator.pop(context);
                                }

                              },
                              hint: AppLocalizations.of(context)!.translate('type_new_password')!,
                              controller: passwordController,
                              globalKey: formKeyFirst,
                              textInputType: TextInputType.visiblePassword,

                            );

                          });
                    },
                    title: Text(AppLocalizations.of(context)!.translate('change_pass')!),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {

                            return ProfileBottomSheet(
                              onUpdatePressedCallback: () {

                                if (formKeySecond.currentState!.validate()) {

                                  _updateUsername(
                                      widget.userId,
                                      emailController.text
                                          .trim());
                                  Navigator.pop(context);
                                }

                              },
                              hint: AppLocalizations.of(context)!.translate('type_new_email')!,
                              controller: emailController,
                              globalKey: formKeySecond,
                              textInputType: TextInputType.emailAddress,

                            );


                          });
                    },
                    title: Text(AppLocalizations.of(context)!.translate('change_email')!),
                    subtitle: Text(cubit.userDetails!.username.toString()),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ),
                )
              ],
            );
          }

          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primary,
            ),
          );
        },
      ),
    );
  }
}




