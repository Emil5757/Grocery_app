import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// White page under the 56 px app bar (back arrow, 18 bold title, hairline)
/// shared by Menu, About Us, FAQ, Terms & Conditions and Help.
///
/// `children` scroll in a column with 20 px side margins. `topPadding` is
/// the gap under the app bar, in design units.
class SupportScaffold extends StatelessWidget {
  const SupportScaffold({
    super.key,
    required this.title,
    required this.children,
    this.topPadding = 0,
    this.backgroundColor = AppColors.white,
  });

  final String title;
  final List<Widget> children;
  final double topPadding;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(
          title: title,
          height: 56,
          titleStyle: AppTextStyles.section18Bold,
        ),
        body: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(20.w, topPadding.h, 20.w, 40.h),
          children: children,
        ),
      ),
    );
  }
}
