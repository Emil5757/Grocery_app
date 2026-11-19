import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_switch_tile.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';

/// App / Phone Number / Offer notification switches.
class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() => _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // TODO: persist these once there is local storage or a backend.
  bool _app = true;
  bool _phone = true;
  bool _offer = false;

  @override
  Widget build(BuildContext context) {
    return CustomCardScaffold(
      title: AppTexts.notificationTitle,
      expand: true,
      cardPadding: EdgeInsets.fromLTRB(AppSizes.cardPadding.w, 40.h, AppSizes.cardPadding.w, 30.h),
      child: Column(
        children: [
          CustomSwitchTile(title: AppTexts.appNotification, value: _app, onChanged: (v) => setState(() => _app = v)),
          CustomSwitchTile(title: AppTexts.phoneNotification, value: _phone, onChanged: (v) => setState(() => _phone = v)),
          CustomSwitchTile(title: AppTexts.offerNotification, value: _offer, onChanged: (v) => setState(() => _offer = v)),
        ],
      ),
    );
  }
}
