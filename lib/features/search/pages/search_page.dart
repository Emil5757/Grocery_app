import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_list_tile.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/search_model.dart';
import '../widgets/filter_sheet.dart';

/// Search field with filter button, Cancel, and Recent Searches.
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search(String query) {
    if (query.trim().isEmpty) return;
    Go.to(context, Pager.searchResult(query.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.search),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.pagePadding.w,
          vertical: 30.h,
        ),
        children: [
          Row(
            children: [
              Expanded(
                child: CustomSearchField(
                  controller: _controller,
                  autofocus: true,
                  onSubmitted: _search,
                  onFilterTap: () => Go.sheet(context, const FilterSheet()),
                ),
              ),
              20.horizontalSpace,
              GestureDetector(
                onTap: () => Go.back(context),
                child: Text(
                  AppTexts.cancel,
                  style: AppTextStyles.body16Regular,
                ),
              ),
            ],
          ),
          30.verticalSpace,
          Text(AppTexts.recentSearches, style: AppTextStyles.section18Medium),
          8.verticalSpace,
          for (final term in SearchModel.recentSearches)
            CustomListTile(
              title: term,
              titleStyle: AppTextStyles.body16Regular.copyWith(
                color: AppColors.textGrey,
              ),
              trailing: Icon(
                Icons.north_west,
                color: AppColors.primary,
                size: AppSizes.icon20.r,
              ),
              onTap: () => _search(term),
            ),
        ],
      ),
    );
  }
}
