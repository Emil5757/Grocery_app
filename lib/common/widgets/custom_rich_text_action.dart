import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

/// "Don't Have Account?  Sign up" / "Did you don't get code?  Resend".
class CustomRichTextAction extends StatefulWidget {
  const CustomRichTextAction({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  final String text;
  final String actionText;
  final VoidCallback onTap;

  @override
  State<CustomRichTextAction> createState() => _CustomRichTextActionState();
}

class _CustomRichTextActionState extends State<CustomRichTextAction> {
  late final TapGestureRecognizer _recognizer = TapGestureRecognizer()..onTap = widget.onTap;

  @override
  void didUpdateWidget(covariant CustomRichTextAction oldWidget) {
    super.didUpdateWidget(oldWidget);
    _recognizer.onTap = widget.onTap;
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: '${widget.text}  ',
        style: AppTextStyles.body16Regular.copyWith(color: AppColors.textGrey),
        children: [
          TextSpan(
            text: widget.actionText,
            recognizer: _recognizer,
            style: AppTextStyles.body16SemiBold.copyWith(color: AppColors.primary),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
