import 'package:exams_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/widgets/custom_button_widget.dart';
import '../../../../core/widgets/custom_edit_text.dart';

class ProfileBottomSheet extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final VoidCallback onUpdatePressedCallback;
  final GlobalKey<FormState> globalKey;
  final TextInputType textInputType;


  const ProfileBottomSheet({Key? key, required this.controller, required this.hint,
    required this.onUpdatePressedCallback, required this.globalKey, required this.textInputType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom),
        color: const Color(0xff757575),
        child: Container(
          padding: const EdgeInsets.all(25.0),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )),
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomEditText(
                    hint: hint,
                    controller: controller,
                    inputType: textInputType,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return AppStrings.required;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: CustomButtonWidget(
                        text: AppLocalizations.of(context)!.translate('update')!,
                        onPress: onUpdatePressedCallback,
                      ),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Expanded(
                      flex: 4,
                      child: CustomButtonWidget(
                        text: AppLocalizations.of(context)!.translate('cancel')!,
                        onPress: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}