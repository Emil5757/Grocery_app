import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/order_model.dart';
import '../widgets/order_card.dart';

/// "My Order" with All / Running / Previous tabs.
class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    const all = OrderModel.all;
    final running = all.where((o) => o.status.isRunning).toList();
    final previous = all.where((o) => !o.status.isRunning).toList();
    final tabs = {AppTexts.all: all, AppTexts.running: running, AppTexts.previous: previous};

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldGrey,
        appBar: CustomAppBar(title: AppTexts.myOrder, showDivider: false),
        body: Column(
          children: [
            ColoredBox(
              color: AppColors.white,
              child: TabBar(
                indicatorColor: AppColors.primary,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: AppColors.transparent,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textGrey,
                labelPadding: EdgeInsets.zero,
                tabs: [
                  for (final e in tabs.entries)
                    Tab(
                      height: 60.h,
                      child: Text.rich(
                        TextSpan(
                          text: '${e.key} ',
                          style: AppTextStyles.title20Bold.copyWith(color: null),
                          children: [
                            TextSpan(
                              text: AppTexts.tabCount(e.value.length),
                              style: AppTextStyles.label14Regular.copyWith(color: null),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  for (final orders in tabs.values)
                    orders.isEmpty
                        ? Pager.noOrders
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                            itemCount: orders.length,
                            separatorBuilder: (_, _) => 12.verticalSpace,
                            itemBuilder: (_, i) => OrderCard(
                              order: orders[i],
                              onTap: () => Go.to(context, Pager.orderDetails(orders[i])),
                            ),
                          ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
