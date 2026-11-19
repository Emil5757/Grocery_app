import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/cubits/cart/cart_cubit.dart';
import '../../../common/widgets/custom_confirm_dialog.dart';
import '../../../common/widgets/custom_list_tile.dart';
import '../../../common/widgets/custom_white_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/profile_model.dart';
import '../widgets/profile_header.dart';

/// Profile tab: header, quick actions (All Order / Voucher / Address) and
/// the menu list. `onBack` lets the bottom-nav shell switch tabs.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.onBack});

  final VoidCallback? onBack;

  Future<void> _handle(BuildContext context, ProfileAction action) async {
    switch (action) {
      case ProfileAction.orders:
        Go.to(context, Pager.myOrders);
      case ProfileAction.voucher:
        Go.to(context, Pager.offers);
      case ProfileAction.address:
        Go.to(context, Pager.deliveryAddress);
      case ProfileAction.myProfile:
        Go.to(context, Pager.editProfile);
      case ProfileAction.notification:
        Go.to(context, Pager.notifications);
      case ProfileAction.setting:
        Go.to(context, Pager.setting);
      case ProfileAction.payment:
        Go.to(context, Pager.paymentOption);
      case ProfileAction.logOut:
        final ok = await Go.dialog<bool>(
          context,
          const CustomConfirmDialog(message: AppTexts.logOutConfirm),
        );
        if (ok == true && context.mounted) {
          context.read<CartCubit>().clear();
          Go.removeAll(context, Pager.welcome);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = 290.h;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        color: AppColors.scaffoldGrey,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 40.h),
          child: Stack(
            children: [
              ProfileHeader(
                user: UserModel.demo,
                height: headerHeight + 80.h,
                onBack: onBack,
                onMenu: () => Go.to(context, Pager.menu),
                // TODO: pick a photo once an image picker is added.
                onCameraTap: () {},
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, headerHeight, 20.w, 0),
                child: Column(
                  children: [
                    CustomWhiteCard(
                      radius: AppSizes.radius16,
                      padding: EdgeInsets.symmetric(vertical: 34.h),
                      child: Row(
                        children: [
                          for (final item in ProfileMenuItem.quickActions)
                            Expanded(
                              child: InkWell(
                                onTap: () => _handle(context, item.action),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(item.icon, height: 28.r),
                                    14.verticalSpace,
                                    Text(item.label, style: AppTextStyles.body16Regular),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    CustomWhiteCard(
                      radius: AppSizes.radius16,
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
                      child: Column(
                        children: [
                          for (final item in ProfileMenuItem.menu)
                            CustomListTile(
                              title: item.label,
                              titleStyle: AppTextStyles.section18Regular,
                              leading: SizedBox(
                                width: 30.r,
                                child: SvgPicture.asset(item.icon, height: 26.r),
                              ),
                              onTap: () => _handle(context, item.action),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
