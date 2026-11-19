import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grocery_app/common/cubits/address/address_cubit.dart';
import 'package:grocery_app/common/cubits/cart/cart_cubit.dart';
import 'package:grocery_app/common/models/category_model.dart';
import 'package:grocery_app/common/models/pack_model.dart';
import 'package:grocery_app/common/models/product_model.dart';
import 'package:grocery_app/core/constants/app_themes.dart';
import 'package:grocery_app/core/navigation/pager.dart';

Future<CartCubit> _pump(WidgetTester tester, Widget page, {CartCubit? cart}) async {
  tester.view
    ..physicalSize = const Size(1242, 2688) // 414 x 896 @3x
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final cubit = cart ?? CartCubit();
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: cubit),
          BlocProvider(create: (_) => AddressCubit()),
        ],
        child: MaterialApp(theme: AppThemes.light, home: page),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 500));
  return cubit;
}

void main() {
  group('CartCubit', () {
    test('adds, merges, updates and totals', () {
      final cart = CartCubit()
        ..add(ProductModel.potato)
        ..add(ProductModel.potato, quantity: 2)
        ..add(ProductModel.tomato);
      expect(cart.state.items.length, 2);
      expect(cart.state.totalItems, 4);
      expect(cart.state.subtotal, 12 * 3 + 12);

      cart.setQuantity(ProductModel.tomato, 0);
      expect(cart.state.items.length, 1);

      expect(cart.applyCoupon('nope'), isFalse);
      expect(cart.applyCoupon('egrocery'), isTrue);
      expect(cart.state.total, closeTo(36 * 0.85, 0.001));
    });
  });

  // Every new page renders at phone size without overflow or exceptions.
  final pages = <String, Widget Function()>{
    'main': () => Pager.main,
    'search': () => Pager.search,
    'searchResult': () => Pager.searchResult('Grocey Product'),
    'categoryProducts': () => Pager.categoryProducts(CategoryModel.all.first),
    'productDetails': () => Pager.productDetails(ProductModel.broccoli),
    'newItems': () => Pager.newItems,
    'popularPack': () => Pager.popularPack,
    'packDetails': () => Pager.packDetails(PackModel.popular.first),
    'createMyPack': () => Pager.createMyPack,
    'bundleDetails': () => Pager.bundleDetails({ProductModel.cauliflower: 2, ProductModel.tomato: 1}),
    'cart (empty)': () => Pager.cart,
    'checkout': () => Pager.checkout,
    'orderSuccess': () => Pager.orderSuccess,
    'orderFailed': () => Pager.orderFailed,
    'noOrders': () => Pager.noOrders,
  };
  for (final e in pages.entries) {
    testWidgets('${e.key} renders', (tester) async {
      await _pump(tester, e.value());
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('cart with items renders and checkout pays', (tester) async {
    final cart = CartCubit()..add(ProductModel.potato, quantity: 2);
    await _pump(tester, Pager.cart, cart: cart);
    expect(find.text('Checkout'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('main tabs switch', (tester) async {
    await _pump(tester, Pager.main);
    await tester.tap(find.text('Menu'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Choose a Category'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('My Favorite List'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('filter sheet opens, expands and applies', (tester) async {
    await _pump(tester, Pager.search);
    await tester.tap(find.byType(SvgPicture)); // the green filter button's icon
    await tester.pumpAndSettle();
    expect(find.text('Apply Filter'), findsOneWidget);
    await tester.tap(find.text('See All').first);
    await tester.pump();
    expect(find.text('Meat & Fish'), findsOneWidget);
    await tester.ensureVisible(find.text('Apply Filter'));
    await tester.tap(find.text('Apply Filter'));
    await tester.pumpAndSettle();
    expect(find.text('Apply Filter'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('create my pack shows the selection bar', (tester) async {
    await _pump(tester, Pager.createMyPack);
    await tester.tap(find.byIcon(Icons.add).first);
    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pump();
    expect(find.text('x2'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
