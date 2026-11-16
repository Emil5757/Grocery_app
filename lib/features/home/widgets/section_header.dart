import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';

/// "Popular Pack ............ View All".
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  final String title;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.section18Regular)),
        GestureDetector(
          onTap: onViewAll,
          child: Text(
            AppTexts.viewAll,
            style: AppTextStyles.label14Medium.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
