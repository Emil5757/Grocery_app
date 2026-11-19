import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/coupon_model.dart';
import '../widgets/coupon_ticket.dart';

/// "Offer And Promos": voucher tickets. Tap one for its details.
class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final Set<String> _collected = {};

  @override
  Widget build(BuildContext context) {
    const coupons = CouponModel.demo;
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.offerAndPromos),
      body: ListView(
        padding: EdgeInsets.fromLTRB(AppSizes.pagePadding.w, 30.h, AppSizes.pagePadding.w, 30.h),
        children: [
          Text(AppTexts.couponsToUse(coupons.length), style: AppTextStyles.section18Bold),
          24.verticalSpace,
          for (final c in coupons) ...[
            CouponTicket(
              coupon: c,
              collected: _collected.contains(c.id),
              onCollect: () => setState(() => _collected.add(c.id)),
              onTap: () => Go.to(context, Pager.couponDetails(c)),
            ),
            20.verticalSpace,
          ],
        ],
      ),
    );
  }
}
