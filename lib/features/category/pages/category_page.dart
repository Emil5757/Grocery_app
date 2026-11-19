import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/data/category_data.dart';
import '../../../common/models/category_model.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_texts.dart';
import '../../../core/navigation/go.dart';
import '../../../core/navigation/pager.dart';
import '../widgets/category_item.dart';

/// "Choose a Category" (Menu tab).
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selected = 0;

  void _open(int i) {
    setState(() => _selected = i);
    final category = CategoryData.all[i];
    // "Pack" holds bundles, not single products.
    Go.to(
      context,
      category.type == CategoryType.pack ? Pager.popularPack : Pager.categoryProducts(category),
    );
  }

  @override
  Widget build(BuildContext context) {
    const categories = CategoryData.all;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          AppSizes.pagePadding.w,
          50.h,
          AppSizes.pagePadding.w,
          40.h,
        ),
        child: Column(
          children: [
            Text(AppTexts.chooseCategory, style: AppTextStyles.display32Bold),
            40.verticalSpace,
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 28.h,
                mainAxisExtent: 135.r,
              ),
              itemBuilder: (_, i) => CategoryItem(
                category: categories[i],
                selected: i == _selected,
                onTap: () => _open(i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
