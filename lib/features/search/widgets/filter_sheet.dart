import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/category_model.dart';
import '../../../common/widgets/custom_bottom_sheet.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_chip.dart';
import '../../../common/widgets/custom_rating_stars.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../data/models/search_model.dart';

/// Filter Popup / Filter Full: sort, price range, categories, brand, rating.
/// Starts from [initial] and pops with the new [FilterResult].
class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key, this.initial = FilterResult.none});

  final FilterResult initial;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  static const _fullRange = RangeValues(SearchModel.minPrice, SearchModel.maxPrice);

  late SortOption _sort = widget.initial.sortBy;
  late RangeValues _range = RangeValues(widget.initial.minPrice, widget.initial.maxPrice);
  late final Set<CategoryType> _categories = {...widget.initial.categories};
  late final Set<String> _brands = {...widget.initial.brands};
  late int _rating = widget.initial.rating;
  // Open "See All" straight away when a hidden chip is already selected.
  late bool _allCategories = SearchModel.categories
      .skip(3)
      .any((c) => _categories.contains(c.type));
  late bool _allBrands = SearchModel.brands.skip(3).any(_brands.contains);

  void _reset() => setState(() {
    _sort = SortOption.popularity;
    _range = _fullRange;
    _categories.clear();
    _brands
      ..clear()
      ..add(AppTexts.any);
    _rating = 0;
  });

  void _apply() => Go.back(
    context,
    FilterResult(
      sortBy: _sort,
      minPrice: _range.start.roundToDouble(),
      maxPrice: _range.end.roundToDouble(),
      categories: {..._categories},
      brands: {..._brands},
      rating: _rating,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.92,
      ),
      child: CustomBottomSheet(
        title: AppTexts.filter,
        actionText: AppTexts.reset,
        onAction: _reset,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sortRow(),
              28.verticalSpace,
              Text(AppTexts.priceRange, style: AppTextStyles.section18SemiBold),
              _priceSlider(),
              24.verticalSpace,
              Text(AppTexts.categories, style: AppTextStyles.section18SemiBold),
              16.verticalSpace,
              _chips(
                [for (final c in SearchModel.categories) (c.label, c.type)],
                _categories,
                _allCategories,
                () => setState(() => _allCategories = true),
              ),
              28.verticalSpace,
              Text(AppTexts.brand, style: AppTextStyles.section18SemiBold),
              16.verticalSpace,
              _chips(
                [for (final b in SearchModel.brands) (b, b)],
                _brands,
                _allBrands,
                () => setState(() => _allBrands = true),
              ),
              28.verticalSpace,
              Text(AppTexts.ratingStar, style: AppTextStyles.section18SemiBold),
              14.verticalSpace,
              CustomRatingStars(
                rating: _rating.toDouble(),
                size: 40,
                onChanged: (v) => setState(() => _rating = v),
              ),
              36.verticalSpace,
              CustomButton(text: AppTexts.applyFilter, onTap: _apply),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sortRow() => Row(
    children: [
      Expanded(
        child: Text(AppTexts.sortBy, style: AppTextStyles.section18SemiBold),
      ),
      PopupMenuButton<SortOption>(
        initialValue: _sort,
        onSelected: (v) => setState(() => _sort = v),
        itemBuilder: (_) => [
          for (final o in SortOption.values)
            PopupMenuItem(
              value: o,
              child: Text(o.label, style: AppTextStyles.body16Regular),
            ),
        ],
        child: Row(
          children: [
            Text(_sort.label, style: AppTextStyles.section18SemiBold),
            6.horizontalSpace,
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.primary,
              size: 28.r,
            ),
          ],
        ),
      ),
    ],
  );

  Widget _priceSlider() => Column(
    children: [
      SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: AppColors.primary,
          inactiveTrackColor: AppColors.divider,
          thumbColor: AppColors.primary,
          overlayColor: AppColors.shadow,
          trackHeight: 6.h,
          rangeThumbShape: RoundRangeSliderThumbShape(
            enabledThumbRadius: 12.r,
            elevation: 2,
          ),
          showValueIndicator: ShowValueIndicator.never,
        ),
        child: RangeSlider(
          values: _range,
          min: SearchModel.minPrice,
          max: SearchModel.maxPrice,
          onChanged: (v) => setState(() => _range = v),
        ),
      ),
      LayoutBuilder(
        builder: (context, c) {
          // Labels follow the thumbs (slider has 24 px side padding).
          final track = c.maxWidth - 48.r;
          double x(double v) => 24.r + track * v / SearchModel.maxPrice - 16.w;
          return SizedBox(
            height: 22.h,
            child: Stack(
              children: [
                Positioned(
                  left: x(_range.start),
                  child: Text(
                    AppTexts.dollars(_range.start),
                    style: AppTextStyles.body16Regular,
                  ),
                ),
                Positioned(
                  left: x(_range.end),
                  child: Text(
                    AppTexts.dollars(_range.end),
                    style: AppTextStyles.body16Regular,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ],
  );

  /// 3-column chip grid; "See All" reveals the rest. Options are
  /// (label, value) pairs.
  Widget _chips<T>(
    List<(String, T)> options,
    Set<T> selected,
    bool showAll,
    VoidCallback onSeeAll,
  ) {
    final visible = showAll ? options : options.take(3).toList();
    return LayoutBuilder(
      builder: (context, c) {
        final gap = 14.w;
        final width = (c.maxWidth - gap * 2) / 3;
        return Wrap(
          spacing: gap,
          runSpacing: 14.h,
          children: [
            for (final (label, value) in visible)
              SizedBox(
                width: width,
                child: CustomChip(
                  label: label,
                  isSelected: selected.contains(value),
                  onTap: () => setState(
                    () => selected.contains(value)
                        ? selected.remove(value)
                        : selected.add(value),
                  ),
                ),
              ),
            if (!showAll)
              SizedBox(
                width: width,
                child: CustomChip(
                  label: AppTexts.seeAll,
                  isSelected: false,
                  onTap: onSeeAll,
                ),
              ),
          ],
        );
      },
    );
  }
}
