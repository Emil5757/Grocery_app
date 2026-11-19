import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grocery_app/common/cubits/address/address_cubit.dart';
import 'package:grocery_app/common/cubits/cart/cart_cubit.dart';
import 'package:grocery_app/common/cubits/review/review_cubit.dart';
import 'package:grocery_app/common/cubits/search_history/search_history_cubit.dart';
import 'package:grocery_app/common/cubits/user/user_cubit.dart';
import 'package:grocery_app/common/data/product_data.dart';
import 'package:grocery_app/common/data/review_data.dart';
import 'package:grocery_app/common/models/category_model.dart';
import 'package:grocery_app/common/models/review_model.dart';
import 'package:grocery_app/core/constants/app_themes.dart';
import 'package:grocery_app/core/navigation/pager.dart';
import 'package:grocery_app/features/product/pages/product_details_page.dart';
import 'package:grocery_app/features/search/data/models/search_model.dart';
import 'package:grocery_app/features/search/pages/search_result_page.dart';

Future<void> _pump(
  WidgetTester tester,
  Widget page, {
  ReviewCubit? reviews,
  SearchHistoryCubit? history,
  UserCubit? user,
}) async {
  tester.view
    ..physicalSize = const Size(1242, 2688)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => AddressCubit()),
          BlocProvider.value(value: user ?? UserCubit()),
          BlocProvider.value(value: reviews ?? ReviewCubit()),
          BlocProvider.value(value: history ?? SearchHistoryCubit()),
        ],
        child: MaterialApp(theme: AppThemes.light, home: page),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  group('FilterResult', () {
    test('none keeps every match, in catalogue order for equal ratings', () {
      expect(FilterResult.none.apply('').length, ProductData.all.length);
      expect(FilterResult.none.activeCount, 0);
    });

    test('price, category and sort narrow and order the list', () {
      const f = FilterResult(
        sortBy: SortOption.priceHighToLow,
        maxPrice: 20,
        categories: {CategoryType.gym, CategoryType.eyeWears},
      );
      final r = f.apply('');
      expect(r, isNotEmpty);
      expect(r.every((p) => p.price <= 20), isTrue);
      expect(r.every((p) => p.category == CategoryType.gym || p.category == CategoryType.eyeWears), isTrue);
      for (var i = 1; i < r.length; i++) {
        expect(r[i - 1].price >= r[i].price, isTrue);
      }
      expect(f.activeCount, 2);
    });
  });

  group('SearchHistoryCubit', () {
    test('adds to the top without duplicates, removes and clears', () {
      final c = SearchHistoryCubit(const ['Meat', 'Tomato'])..add('tomato');
      expect(c.state, ['tomato', 'Meat']);
      c
        ..add('  ')
        ..remove('Meat');
      expect(c.state, ['tomato']);
      c.clear();
      expect(c.state, isEmpty);
    });
  });

  testWidgets('typing on Search shows live results; Enter saves the term', (tester) async {
    final history = SearchHistoryCubit(const []);
    await _pump(tester, Pager.search, history: history);
    await tester.enterText(find.byType(EditableText), 'glasses');
    await tester.pump();
    expect(find.text('4 Products Found'), findsOneWidget);
    expect(find.text('Round Eyeglasses'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'zzzz');
    await tester.pump();
    expect(find.text('No products found'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'Tomato');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    expect(history.state.first, 'Tomato');
    expect(find.byType(SearchResultPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('recent search: tap searches, x removes it, Clear All empties', (tester) async {
    final history = SearchHistoryCubit(const ['Meat', 'Chicken']);
    await _pump(tester, Pager.search, history: history);
    expect(find.text('Recent Searches'), findsOneWidget);

    await tester.tap(find.byTooltip('Remove from recent searches').first);
    await tester.pump();
    expect(history.state, ['Chicken']);

    await tester.tap(find.byTooltip('Put in the search box'));
    await tester.pump();
    expect(find.text('Fresh Whole Chicken'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), '');
    await tester.pump();
    await tester.tap(find.text('Clear All'));
    await tester.pump();
    expect(history.state, isEmpty);
    expect(find.text('Recent Searches'), findsNothing);
  });

  testWidgets('a live result opens Product Details', (tester) async {
    await _pump(tester, Pager.search);
    await tester.enterText(find.byType(EditableText), 'kettle');
    await tester.pump();
    await tester.tap(find.text('Kettlebell'));
    await tester.pumpAndSettle();
    expect(find.byType(ProductDetailsPage), findsOneWidget);
  });

  testWidgets('Search Result is editable and clears filters', (tester) async {
    await _pump(
      tester,
      Pager.searchResult('', filter: const FilterResult(categories: {CategoryType.petCare})),
    );
    expect(find.text('4 Products Found'), findsOneWidget);
    expect(find.textContaining('1 filter on'), findsOneWidget);
    await tester.enterText(find.byType(EditableText), 'dog');
    await tester.pump();
    expect(find.text('2 Products Found'), findsOneWidget);
    await tester.tap(find.textContaining('Clear filters'));
    await tester.pump();
    expect(find.textContaining('filter on'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('submitted comment shows at the top of the product reviews', (tester) async {
    final reviews = ReviewCubit();
    final user = UserCubit()
      ..updateInfo(firstName: 'Jonny', lastName: 'Albas', gender: 'Male', birthday: '01.01.1990');
    const product = ProductData.tomato;
    await _pump(tester, Pager.review(product: product), reviews: reviews, user: user);
    expect(find.text('320 reviews'), findsOneWidget);

    await tester.tap(find.byTooltip('Submit Review'));
    await tester.pumpAndSettle();
    expect(find.text('Jonny Albas'), findsOneWidget, reason: 'reviewer is the signed-in user');
    await tester.tap(find.byIcon(Icons.star_rounded).at(3), warnIfMissed: false);
    await tester.pump();
    await tester.enterText(find.byType(EditableText), 'Very fresh, will buy again');
    await tester.ensureVisible(find.text('Submit'));
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(reviews.state.single.productId, product.id);
    expect(find.text('Very fresh, will buy again'), findsOneWidget);
    expect(find.text('Jonny Albas'), findsOneWidget);
    expect(find.text('Just now'), findsOneWidget);
    expect(find.text('321 reviews'), findsOneWidget);

    // Another product does not show it.
    await _pump(tester, Pager.review(product: ProductData.potato), reviews: reviews, user: user);
    expect(find.text('Very fresh, will buy again'), findsNothing);
    expect(find.text('320 reviews'), findsOneWidget);
  });

  test('summary adds the new rating', () {
    final s = ReviewData.summary.plus(1);
    expect(s.total, 321);
    expect(s.counts.last, ReviewData.summary.counts.last + 1);
    expect(s.average, lessThan(ReviewData.summary.average));
    expect(s.averageLabel, matches(RegExp(r'^\d\.\d$')));
    expect(ReviewData.summary.averageLabel, '4.5');
    expect(const RatingSummary(average: 4.956987568956798, total: 1, counts: [1, 0, 0, 0, 0]).averageLabel, '5.0');
  });
}
