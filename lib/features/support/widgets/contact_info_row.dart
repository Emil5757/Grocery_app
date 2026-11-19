import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_texts.dart';
import '../../../core/extensions/context_extension.dart';

/// Contact Us row: green ring icon (30 px) and one or more lines of text,
/// 15 px apart. Tapping a line copies it, since the app has no dialer or
/// mail plugin yet.
class ContactInfoRow extends StatelessWidget {
  const ContactInfoRow({
    super.key,
    required this.icon,
    required this.lines,
    required this.style,
    this.lineGap = 0,
    this.centerIcon = false,
    this.iconTop = 0,
    this.textTop = 0,
  });

  /// Nudges (design units) that line the first text line up with the ring
  /// exactly as drawn: the phone numbers start 1.6 above the ring, the
  /// address 2 below it.
  final double iconTop;
  final double textTop;

  final String icon;
  final List<String> lines;
  final TextStyle style;

  /// Extra space between separate lines (the two phone numbers).
  final double lineGap;

  /// Single-line rows centre the icon on the text; multi-line rows align
  /// it with the first line.
  final bool centerIcon;

  Future<void> _copy(BuildContext context, String text) async {
    final value = text.replaceAll('\n', ', ');
    var copied = true;
    try {
      await Clipboard.setData(ClipboardData(text: value));
    } on PlatformException {
      // Some browsers block clipboard access; show the value instead.
      copied = false;
    }
    if (context.mounted) context.showSnack(copied ? AppTexts.copiedToClipboard : value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: centerIcon ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: iconTop.h),
          child: SvgPicture.asset(icon, width: 30.r, height: 30.r),
        ),
        15.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (textTop > 0) textTop.verticalSpace,
              for (final (i, line) in lines.indexed) ...[
                if (i > 0) lineGap.verticalSpace,
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _copy(context, line),
                  child: Text(line, style: style),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
