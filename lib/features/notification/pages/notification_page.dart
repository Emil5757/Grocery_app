import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/notification_model.dart';
import '../widgets/notification_tile.dart';

/// Notification list. The gear opens the notification settings.
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  void _open(BuildContext context, NotificationTarget target) => Go.to(
        context,
        switch (target) {
          NotificationTarget.offers => Pager.offers,
          NotificationTarget.promos => Pager.promos,
          NotificationTarget.orders => Pager.myOrders,
          NotificationTarget.tracking => Pager.orderTracking,
          NotificationTarget.delivered => Pager.delivered,
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppTexts.notificationTitle,
        actions: [
          IconButton(
            onPressed: () => Go.to(context, Pager.notificationSettings),
            icon: SvgPicture.asset(AppAssets.icProfileSetting, width: AppSizes.icon24.r),
          ),
          8.horizontalSpace,
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(AppSizes.pagePadding.w, 12.h, AppSizes.pagePadding.w, 30.h),
        children: [
          for (final n in NotificationModel.demo)
            NotificationTile(item: n, onTap: () => _open(context, n.target)),
        ],
      ),
    );
  }
}
