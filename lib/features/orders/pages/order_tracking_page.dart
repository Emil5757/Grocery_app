import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/cubits/address/address_cubit.dart';
import '../../../common/models/address_model.dart';
import '../../../common/widgets/custom_avatar.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/navigation/go.dart';
import '../data/models/order_model.dart';
import '../widgets/tracking_info_row.dart';
import '../widgets/tracking_map.dart';

/// Live-looking delivery route on OpenStreetMap with a draggable info sheet.
class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key, this.tileProvider});

  /// Overridable for tests (no network there).
  final TileProvider? tileProvider;

  @override
  Widget build(BuildContext context) {
    final address = context.watch<AddressCubit>().state.current;
    final home = address?.location ?? AddressModel.chhatak;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppColors.white.withValues(alpha: 0.85),
          leading: IconButton(
            onPressed: () => Go.back(context),
            icon: Icon(Icons.arrow_back, size: AppSizes.icon28.r, color: AppColors.textPrimary),
          ),
          title: Text(AppTexts.orderTracking, style: AppTextStyles.title20Bold),
        ),
        body: Stack(
          children: [
            Positioned.fill(child: TrackingMap(home: home, tileProvider: tileProvider)),
            DraggableScrollableSheet(
              initialChildSize: 0.36,
              minChildSize: 0.18,
              maxChildSize: 0.5,
              builder: (context, scroll) => DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.radius24.r)),
                  boxShadow: [BoxShadow(color: AppColors.navShadow, blurRadius: 20.r)],
                ),
                child: ListView(
                  controller: scroll,
                  padding: EdgeInsets.fromLTRB(AppSizes.pagePadding.w, 14.h, AppSizes.pagePadding.w, 30.h),
                  children: [
                    Center(
                      child: Container(
                        width: 50.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    24.verticalSpace,
                    TrackingInfoRow(
                      leading: SvgPicture.asset(AppAssets.icTrackingTime),
                      caption: AppTexts.yourDeliveryTime,
                      value: TrackingModel.deliveryTime,
                    ),
                    TrackingInfoRow(
                      leading: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.promoPurple,
                          borderRadius: BorderRadius.circular(AppSizes.radius8.r),
                        ),
                        child: SvgPicture.asset(AppAssets.icLocation, width: 22.r),
                      ),
                      caption: AppTexts.yourDeliveryAddress,
                      value: address == null ? '' : '${address.address}, ${address.title}',
                    ),
                    12.verticalSpace,
                    const Divider(),
                    12.verticalSpace,
                    TrackingInfoRow(
                      leading: const CustomAvatar(
                        image: AppAssets.avatarSaydul,
                        size: 40,
                        background: AppColors.avatarPeach,
                      ),
                      caption: AppTexts.yourShipper,
                      value: TrackingModel.shipperName,
                      valueStyle: AppTextStyles.section18Bold,
                      trailing: Material(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppSizes.radius8.r),
                        child: InkWell(
                          // TODO: start a phone call once url_launcher is added.
                          onTap: () => context.showSnack(TrackingModel.shipperPhone),
                          borderRadius: BorderRadius.circular(AppSizes.radius8.r),
                          child: SizedBox.square(
                            dimension: 40.r,
                            child: Icon(Icons.call_outlined, color: AppColors.white, size: 22.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
