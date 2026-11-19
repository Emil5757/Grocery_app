import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_white_card.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/support_content_model.dart';
import '../widgets/contact_info_row.dart';

/// "Contact Us": grey page, one white card (radius 21) with phone, e-mail,
/// address and a map with the shop's pin.
class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldGrey,
        appBar: CustomAppBar(
          title: AppTexts.contactUs,
          height: 56,
          titleStyle: AppTextStyles.section18Bold,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 30.h, 16.w, 30.h),
          child: CustomWhiteCard(
            radius: 21,
            padding: EdgeInsets.zero,
            child: SizedBox.expand(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 59.h, 20.w, 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppTexts.contactUs, style: AppTextStyles.title20BoldTight),
                    25.4.verticalSpace,
                    ContactInfoRow(
                      icon: AppAssets.icContactPhone,
                      lines: ContactContent.phones,
                      lineGap: 9,
                      iconTop: 1.6,
                      style: AppTextStyles.body16Tight.copyWith(color: AppColors.textPrimary70),
                    ),
                    25.6.verticalSpace,
                    ContactInfoRow(
                      icon: AppAssets.icContactEmail,
                      lines: const [ContactContent.email],
                      centerIcon: true,
                      style: AppTextStyles.body16Tight.copyWith(color: AppColors.textTertiary),
                    ),
                    25.verticalSpace,
                    ContactInfoRow(
                      icon: AppAssets.icContactLocation,
                      lines: const [ContactContent.address],
                      textTop: 2,
                      style: AppTextStyles.body16Tertiary,
                    ),
                    31.verticalSpace,
                    const _ContactMap(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 342 x 200 window onto the map image, which the design draws at 730 x 382
/// starting 14 px left of and 45 px above the window. The pin sits at
/// (210, 57) inside the window.
class _ContactMap extends StatelessWidget {
  const _ContactMap();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 342 / 200,
      child: LayoutBuilder(
        builder: (context, box) {
          // Scale design units to the window's actual width.
          final s = box.maxWidth / 342;
          return ClipRRect(
            borderRadius: BorderRadius.circular(15 * s),
            child: ColoredBox(
              color: AppColors.mapBackground,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  Positioned(
                    left: -14 * s,
                    top: -45 * s,
                    width: 730 * s,
                    height: 382 * s,
                    child: Image.asset(AppAssets.contactMap, fit: BoxFit.fill),
                  ),
                  Positioned(
                    left: 209 * s,
                    top: 56 * s,
                    child: SvgPicture.asset(AppAssets.icMapPin, width: 19 * s),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
