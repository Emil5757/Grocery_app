import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_empty_state.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';

class OrderSuccessPage extends StatelessWidget {
  const OrderSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomEmptyState(
          illustration: SvgPicture.asset(AppAssets.orderSuccess, width: 126.r),
          title: AppTexts.orderPlaced,
          subtitle: AppTexts.orderPlacedSubtitle,
          buttonText: AppTexts.continueText,
          onButtonTap: () => Go.removeAll(context, Pager.main),
          secondaryText: AppTexts.trackOrder,
          onSecondaryTap: () => Go.to(context, Pager.orderTracking),
        ),
      ),
    );
  }
}
