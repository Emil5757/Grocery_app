import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/support_content_model.dart';
import '../widgets/support_scaffold.dart';

/// "About Us": 20 bold heading and grey paragraphs about one line apart.
class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SupportScaffold(
      title: AppTexts.aboutUs,
      topPadding: 29,
      children: [
        Text(AppTexts.aboutUs, style: AppTextStyles.title20BoldTight),
        20.verticalSpace,
        for (final (i, p) in AboutContent.paragraphs.indexed) ...[
          if (i > 0) 26.verticalSpace,
          Text(p, style: AppTextStyles.paragraph16Muted),
        ],
      ],
    );
  }
}
