import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/pack_model.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';

/// 25 Kg / Medum / 17 with Weight / Size / Item's captions.
class PackStatsRow extends StatelessWidget {
  const PackStatsRow({super.key, required this.pack});

  final PackModel pack;

  Widget _stat(String value, String label, CrossAxisAlignment align) => Column(
    crossAxisAlignment: align,
    children: [
      Text(value, style: AppTextStyles.body16Bold),
      4.verticalSpace,
      Text(label, style: AppTextStyles.label14Grey),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _stat(
          '${pack.weightKg.round()} Kg',
          AppTexts.weight,
          CrossAxisAlignment.start,
        ),
        _stat(pack.size, AppTexts.size, CrossAxisAlignment.center),
        _stat('${pack.itemCount}', AppTexts.items, CrossAxisAlignment.end),
      ],
    );
  }
}
