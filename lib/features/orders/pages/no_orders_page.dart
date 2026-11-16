import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_empty_state.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';

/// "Order" screen when the user has never ordered.
class NoOrdersPage extends StatelessWidget {
  const NoOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.order),
      body: CustomEmptyState(
        illustration: SvgPicture.asset(AppAssets.noOrders, width: 160.r),
        title: AppTexts.noOrdersYet,
        subtitle: AppTexts.noOrdersSubtitle,
        buttonText: AppTexts.goBack,
        onButtonTap: () => Go.back(context),
      ),
    );
  }
}
