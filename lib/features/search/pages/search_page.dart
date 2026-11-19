import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/search_history/search_history_cubit.dart';
import '../../../common/models/product_model.dart';
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
import '../widgets/search_product_tile.dart';
import '../widgets/search_status.dart';

/// Search box with filter button and Cancel. Empty box: Recent Searches.
/// Typing: matching products update live. Enter opens Search Results.
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();
  String _query = '';
  FilterResult _filter = FilterResult.none;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setQuery(String value) {
    _controller.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    setState(() => _query = value);
  }

  /// Enter / a recent search: remember it and open the full results.
  void _submit(String query) {
    final q = query.trim();
    if (q.isEmpty && _filter.activeCount == 0) return;
    if (q.isNotEmpty) context.read<SearchHistoryCubit>().add(q);
    _setQuery(q);
    Go.to(context, Pager.searchResult(q, filter: _filter));
  }

  void _openProduct(ProductModel product) {
    context.read<SearchHistoryCubit>().add(_query);
    Go.to(context, Pager.productDetails(product));
  }

  Future<void> _openFilter() async {
    final result = await Go.sheet<FilterResult>(context, FilterSheet(initial: _filter));
    if (result != null && mounted) setState(() => _filter = result);
  }

  @override
  Widget build(BuildContext context) {
    final showResults = _query.trim().isNotEmpty || _filter.activeCount > 0;
    final results = showResults ? _filter.apply(_query) : const <ProductModel>[];
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.search),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w, vertical: 30.h),
        children: [
          Row(
            children: [
              Expanded(
                child: CustomSearchField(
                  controller: _controller,
                  autofocus: true,
                  onChanged: (v) => setState(() => _query = v),
                  onSubmitted: _submit,
                  onFilterTap: _openFilter,
                ),
              ),
              20.horizontalSpace,
              GestureDetector(
                onTap: () => Go.back(context),
                child: Text(AppTexts.cancel, style: AppTextStyles.body16Regular),
              ),
            ],
          ),
          30.verticalSpace,
          if (showResults) ...[
            SearchCountRow(
              count: results.length,
              activeFilters: _filter.activeCount,
              onClearFilters: () => setState(() => _filter = FilterResult.none),
            ),
            8.verticalSpace,
            if (results.isEmpty) const SearchEmpty(),
            for (final p in results) SearchProductTile(product: p, onTap: () => _openProduct(p)),
          ] else
            ..._recent(),
        ],
      ),
    );
  }

  List<Widget> _recent() {
    final history = context.watch<SearchHistoryCubit>();
    if (history.state.isEmpty) return const [];
    return [
      Row(
        children: [
          Expanded(child: Text(AppTexts.recentSearches, style: AppTextStyles.section18Medium)),
          TextButton(
            onPressed: history.clear,
            child: Text(
              AppTexts.clearAll,
              style: AppTextStyles.label14Medium.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
      for (final term in history.state)
        CustomListTile(
          title: term,
          titleStyle: AppTextStyles.body16Regular.copyWith(color: AppColors.textGrey),
          onTap: () => _submit(term),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: AppTexts.useSearch,
                visualDensity: VisualDensity.compact,
                onPressed: () => _setQuery(term),
                icon: Icon(Icons.north_west, color: AppColors.primary, size: AppSizes.icon20.r),
              ),
              IconButton(
                tooltip: AppTexts.removeSearch,
                visualDensity: VisualDensity.compact,
                onPressed: () => history.remove(term),
                icon: Icon(Icons.close, color: AppColors.textGrey, size: AppSizes.icon20.r),
              ),
            ],
          ),
        ),
    ];
  }
}
