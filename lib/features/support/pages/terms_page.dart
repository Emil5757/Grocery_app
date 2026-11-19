import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/support_content_model.dart';
import '../widgets/support_scaffold.dart';

/// "Terms & Conditions": revision heading, intro, then numbered sections.
/// The copy wraps in a 330 px column, narrower than the page, as designed.
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget column(Widget child) => Align(
          alignment: Alignment.centerLeft,
          child: ConstrainedBox(constraints: BoxConstraints(maxWidth: 330.w), child: child),
        );

    return SupportScaffold(
      title: AppTexts.termsAndConditions,
      topPadding: 28,
      children: [
        Text(TermsSectionModel.heading, style: AppTextStyles.body16BoldTight),
        15.verticalSpace,
        column(Text(TermsSectionModel.intro, style: AppTextStyles.paragraph16Muted)),
        for (final (i, section) in TermsSectionModel.sections.indexed) ...[
          20.4.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 21.w,
                child: Text('${i + 1}.', style: AppTextStyles.body16BoldTight),
              ),
              Expanded(child: Text(section.title, style: AppTextStyles.body16BoldTight)),
            ],
          ),
          7.5.verticalSpace,
          column(Text(section.body, style: AppTextStyles.paragraph16Muted)),
        ],
      ],
    );
  }
}
