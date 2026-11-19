import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/cubits/cart/cart_extension.dart';
import '../../../common/cubits/search_history/search_history_cubit.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_masonry_grid.dart';
import '../../../common/widgets/custom_product_card.dart';
import '../../../common/widgets/custom_search_field.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../data/models/search_model.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/search_status.dart';

/// "Search Results": editable query with filter, a count and a staggered
/// product grid over the mock catalogue.
class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key, required this.query, this.filter = FilterResult.none});

  final String query;
  final FilterResult filter;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late final _controller = TextEditingController(text: widget.query);
  late String _query = widget.query;
  late FilterResult _filter = widget.filter;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openFilter() async {
    final result = await Go.sheet<FilterResult>(context, FilterSheet(initial: _filter));
    if (result != null && mounted) setState(() => _filter = result);
  }

  @override
  Widget build(BuildContext context) {
    final results = _filter.apply(_query);
    return Scaffold(
      appBar: const CustomAppBar(title: AppTexts.searchResults),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.pagePadding.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchField(
              controller: _controller,
              onChanged: (v) => setState(() => _query = v),
              onSubmitted: (v) => context.read<SearchHistoryCubit>().add(v),
              onFilterTap: _openFilter,
            ),
            24.verticalSpace,
            SearchCountRow(
              count: results.length,
              activeFilters: _filter.activeCount,
              style: AppTextStyles.title20Regular,
              onClearFilters: () => setState(() => _filter = FilterResult.none),
            ),
            20.verticalSpace,
            if (results.isEmpty)
              const Center(child: SearchEmpty())
            else
              CustomMasonryGrid(
                children: [
                  for (final p in results)
                    CustomProductCard(
                      image: Image.asset(p.image),
                      name: p.name,
                      unit: p.unit,
                      price: p.price,
                      onTap: () => Go.to(context, Pager.productDetails(p)),
                      onAdd: () => context.addToCart(p),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
