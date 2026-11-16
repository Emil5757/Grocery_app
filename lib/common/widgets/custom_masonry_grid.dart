import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Two staggered columns (Search Results, Vegetables, New Item, Popular Pack,
/// Create My Pack). Children alternate left / right and keep their own
/// height. It does not scroll: put it inside a scroll view.
class CustomMasonryGrid extends StatelessWidget {
  const CustomMasonryGrid({
    super.key,
    required this.children,
    this.spacing = 16,
  });

  final List<Widget> children;

  /// Design gap between cards, before scaling.
  final double spacing;

  Widget _column(int start) => Expanded(
    child: Column(
      children: [
        for (var i = start; i < children.length; i += 2) ...[
          if (i > start) spacing.verticalSpace,
          children[i],
        ],
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_column(0), spacing.horizontalSpace, _column(1)],
    );
  }
}
