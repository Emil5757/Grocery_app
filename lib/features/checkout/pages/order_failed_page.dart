import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_empty_state.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';

class OrderFailedPage extends StatelessWidget {
  const OrderFailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomEmptyState(
          illustration: SvgPicture.asset(AppAssets.orderFailed, width: 126.r),
          title: AppTexts.orderFailed,
          subtitle: AppTexts.orderFailedSubtitle,
          buttonText: AppTexts.tryAgain,
          onButtonTap: () => Go.back(context),
        ),
      ),
    );
  }
}
