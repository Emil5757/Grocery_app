import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A one-line label whose centre sits `centerY` below the top of a
/// `height`-tall slot, both in design units. Used where the design packs a
/// heading tightly against the row under it (Help's "Top Questions"), so
/// the position does not drift with the fallback font's line height.
class DesignLabel extends StatelessWidget {
  const DesignLabel({
    super.key,
    required this.text,
    required this.style,
    required this.height,
    required this.centerY,
  });

  final String text;
  final TextStyle style;
  final double height;
  final double centerY;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: (centerY - 15).h,
            height: 30.h,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(text, style: style, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
