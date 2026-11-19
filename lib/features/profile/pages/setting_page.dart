import 'package:flutter/material.dart';

import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_confirm_dialog.dart';
import '../../../common/widgets/custom_list_tile.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/profile_model.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<void> _open(BuildContext context, SettingAction action) async {
    switch (action) {
      case SettingAction.language:
        Go.to(context, Pager.language);
      case SettingAction.changePassword:
        Go.to(context, Pager.changePassword);
      case SettingAction.editHomeAddress:
        Go.to(context, Pager.deliveryAddress);
      case SettingAction.location:
        Go.to(context, Pager.orderTracking);
      case SettingAction.profileSettings:
        Go.to(context, Pager.editProfile);
      case SettingAction.deactivate:
        final ok = await Go.dialog<bool>(
          context,
          const CustomConfirmDialog(message: AppTexts.deactivateConfirm),
        );
        // TODO: call the deactivate endpoint once a backend exists.
        if (ok == true && context.mounted) Go.removeAll(context, Pager.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCardScaffold(
      title: AppTexts.setting,
      expand: true,
      child: Column(
        children: [
          for (final item in SettingItem.all)
            CustomListTile(
              title: item.label,
              titleStyle: AppTextStyles.section18Regular,
              onTap: () => _open(context, item.action),
            ),
        ],
      ),
    );
  }
}
