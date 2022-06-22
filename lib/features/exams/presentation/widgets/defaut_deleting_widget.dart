import 'package:flutter/material.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';

class DefaultDeletingWidget extends StatelessWidget {
  const DefaultDeletingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: CircularProgressIndicator()),
          const SizedBox(
            height: 16.0,
          ),
          Text(AppLocalizations.of(context)!.translate('deleting')!,
              style: TextStyle(
                  color: AppColors.primary, fontSize: 16.0)),
        ],
      ),
    );
  }
}
