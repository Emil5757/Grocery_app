import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/support_content_model.dart';
import '../widgets/support_scaffold.dart';

/// "FAQ": numbered 20 bold questions, each followed by grey answer
/// paragraphs.
class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SupportScaffold(
      title: AppTexts.faq,
      topPadding: 28.5,
      children: [
        for (final (i, faq) in FaqModel.items.indexed) ...[
          if (i > 0) 26.verticalSpace,
          Text('${i + 1}. ${faq.question}', style: AppTextStyles.title20BoldTight),
          21.verticalSpace,
          for (final (j, p) in faq.answer.indexed) ...[
            if (j > 0)
              FaqModel.paragraphGaps[math.min(j, FaqModel.paragraphGaps.length) - 1].verticalSpace,
            Text(p, style: AppTextStyles.paragraph16Muted),
          ],
        ],
      ],
    );
  }
}
