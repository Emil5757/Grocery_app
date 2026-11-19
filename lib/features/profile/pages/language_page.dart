import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_card_scaffold.dart';
import '../../../common/widgets/custom_list_tile.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../data/models/profile_model.dart';

/// "Select Language": search, Suggested, All Countries/Regions.
class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selected = 'United States';
  String _query = '';

  List<String> _filter(List<String> list) =>
      list.where((c) => c.toLowerCase().contains(_query.toLowerCase())).toList();

  // TODO: switch the app locale once localisation is added.
  Widget _tile(String country) => CustomListTile(
        title: country,
        titleStyle: AppTextStyles.section18Regular,
        trailing: country == _selected
            ? Icon(Icons.check, color: AppColors.primary, size: AppSizes.icon28.r)
            : const SizedBox.shrink(),
        onTap: () => setState(() => _selected = country),
      );

  Widget _section(String title) => Padding(
        padding: EdgeInsets.only(top: 24.h, bottom: 4.h),
        child: Text(title, style: AppTextStyles.section18Regular.copyWith(color: AppColors.textGrey)),
      );

  @override
  Widget build(BuildContext context) {
    final suggested = _filter(LanguageModel.suggested);
    final all = _filter(LanguageModel.all);
    return CustomCardScaffold(
      title: AppTexts.selectLanguage,
      cardPadding: EdgeInsets.fromLTRB(AppSizes.cardPadding.w, 20.h, AppSizes.cardPadding.w, 30.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchField(onChanged: (v) => setState(() => _query = v)),
          if (suggested.isNotEmpty) ...[_section(AppTexts.suggested), ...suggested.map(_tile)],
          if (all.isNotEmpty) ...[_section(AppTexts.allCountries), ...all.map(_tile)],
        ],
      ),
    );
  }
}
