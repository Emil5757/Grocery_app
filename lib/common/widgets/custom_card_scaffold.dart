import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import 'custom_app_bar.dart';
import 'custom_white_card.dart';

/// Grey page with a white app bar and one rounded white card holding the
/// content (Profile form, Setting, Change Password, Change Phone Number,
/// Select Language, Notification settings, Delivery Address, New Address,
/// My Order Details).
class CustomCardScaffold extends StatelessWidget {
  const CustomCardScaffold({
    super.key,
    required this.title,
    required this.child,
    this.expand = false,
    this.cardPadding,
    this.floatingActionButton,
  });

  final String title;
  final Widget child;

  /// `true`: the card fills the page height (Setting, Delivery Address);
  /// `false`: it wraps its content and the page scrolls.
  final bool expand;
  final EdgeInsetsGeometry? cardPadding;

  /// Drawn over the card's bottom-right corner (Delivery Address "+").
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final outer = EdgeInsets.fromLTRB(16.w, 30.h, 16.w, 30.h);
    final padding =
        cardPadding ??
        EdgeInsets.symmetric(horizontal: AppSizes.cardPadding.w, vertical: 30.h);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.scaffoldGrey,
        appBar: CustomAppBar(title: title),
        body: expand
            ? Padding(
                padding: outer,
                child: Stack(
                  children: [
                    CustomWhiteCard(padding: padding, child: SizedBox.expand(child: child)),
                    if (floatingActionButton != null)
                      Positioned(right: 24.w, bottom: 24.h, child: floatingActionButton!),
                  ],
                ),
              )
            : SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: outer,
                child: CustomWhiteCard(padding: padding, child: child),
              ),
      ),
    );
  }
}
