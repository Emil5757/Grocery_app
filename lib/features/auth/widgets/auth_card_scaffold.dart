import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';

/// Shell of "Forget Password" and "New Password": white app bar with back
/// arrow, grey page, and a white card that runs to the bottom of the screen
/// with a bold heading followed by `children`.
///
/// The keyboard slides over the card (as in the design) instead of
/// squeezing it; the content scrolls so the button can still be reached.
class AuthCardScaffold extends StatelessWidget {
  const AuthCardScaffold({
    super.key,
    required this.title,
    required this.heading,
    required this.children,
  });

  final String title;
  final String heading;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(26.r);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldGrey,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: title, height: 56),
        body: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 30.h, 16.w, 0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
            ),
            child: SizedBox.expand(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(
                  AppSizes.cardPadding.w,
                  80.h,
                  AppSizes.cardPadding.w,
                  24.h + MediaQuery.viewInsetsOf(context).bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(heading, style: AppTextStyles.headline24Bold),
                    ...children,
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
