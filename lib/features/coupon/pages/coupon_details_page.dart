import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_cubit.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../data/models/coupon_model.dart';
import '../widgets/coupon_ticket.dart';

/// Ticket, pitch, terms, expiry and "Redeem Now" (applies the discount to
/// the cart).
class CouponDetailsPage extends StatefulWidget {
  const CouponDetailsPage({super.key, required this.coupon});

  final CouponModel coupon;

  @override
  State<CouponDetailsPage> createState() => _CouponDetailsPageState();
}

class _CouponDetailsPageState extends State<CouponDetailsPage> {
  bool _collected = false;

  void _redeem() {
    context.read<CartCubit>().applyDiscount(widget.coupon.rate);
    context.showSnack(AppTexts.couponRedeemed);
    Go.back(context);
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.coupon;
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.couponDetails),
      body: ListView(
        padding: EdgeInsets.fromLTRB(AppSizes.pagePadding.w, 30.h, AppSizes.pagePadding.w, 30.h),
        children: [
          CouponTicket(coupon: c, collected: _collected, onCollect: () => setState(() => _collected = true)),
          36.verticalSpace,
          Text(AppTexts.couponPitch(c.percent), textAlign: TextAlign.center, style: AppTextStyles.section18Regular.copyWith(height: 1.5)),
          30.verticalSpace,
          for (final term in c.terms)
            Padding(
              padding: EdgeInsets.only(bottom: 22.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Container(width: 20.w, height: 4.h, color: AppColors.primary),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Text(term, style: AppTextStyles.body16Regular.copyWith(color: AppColors.textSecondary)),
                  ),
                ],
              ),
            ),
          10.verticalSpace,
          Text(AppTexts.expiryLong(c.expiry), style: AppTextStyles.section18Regular),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(AppSizes.pagePadding.w, 8.h, AppSizes.pagePadding.w, 8.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomButton(text: AppTexts.redeemNow, onTap: _redeem),
              TextButton(
                // TODO: Go.to(context, Pager.terms) once the Terms page is built.
                onPressed: () {},
                child: Text(AppTexts.termsAndCondition, style: AppTextStyles.body16Regular),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
