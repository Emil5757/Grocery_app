import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grocery_app/common/cubits/address/address_cubit.dart';
import 'package:grocery_app/common/cubits/cart/cart_cubit.dart';
import 'package:grocery_app/common/cubits/review/review_cubit.dart';
import 'package:grocery_app/common/cubits/search_history/search_history_cubit.dart';
import 'package:grocery_app/common/cubits/user/user_cubit.dart';
import 'package:grocery_app/common/models/address_model.dart';
import 'package:grocery_app/core/constants/app_themes.dart';
import 'package:grocery_app/core/navigation/pager.dart';
import 'package:grocery_app/features/coupon/data/models/coupon_model.dart';
import 'package:grocery_app/features/orders/data/models/order_model.dart';
import 'package:grocery_app/features/orders/pages/order_tracking_page.dart';

/// 1x1 transparent PNG so map tests never touch the network.
final _blank = Uint8List.fromList(const [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
]);

class _NoNetworkTiles extends TileProvider {
  @override
  ImageProvider getImage(TileCoordinates coordinates, TileLayer options) => MemoryImage(_blank);
}

Future<void> _pump(WidgetTester tester, Widget page, {AddressCubit? addresses, CartCubit? cart, UserCubit? user}) async {
  tester.view
    ..physicalSize = const Size(1242, 2688) // 414 x 896 @3x
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: cart ?? CartCubit()),
          BlocProvider.value(value: addresses ?? AddressCubit()),
          BlocProvider.value(value: user ?? UserCubit()),
          BlocProvider(create: (_) => ReviewCubit()),
          BlocProvider(create: (_) => SearchHistoryCubit()),
        ],
        child: MaterialApp(theme: AppThemes.light, home: page),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  group('AddressCubit', () {
    test('select, add as default, update, remove keeps a valid selection', () {
      final c = AddressCubit();
      final start = c.state.addresses.length;
      c.select(2);
      c.add(const AddressModel(title: 'New', address: 'Street', phone: '+8801700000000'), makeDefault: true);
      expect(c.state.addresses.length, start + 1);
      expect(c.state.current!.title, 'New');
      c.update(0, const AddressModel(title: 'Edited', address: 'x', phone: '1'));
      expect(c.state.addresses.first.title, 'Edited');
      c.remove(c.state.selected);
      expect(c.state.selected, lessThan(c.state.addresses.length));
    });
  });

  final pages = <String, Widget Function()>{
    'profile': () => Pager.profile(),
    'editProfile': () => Pager.editProfile,
    'setting': () => Pager.setting,
    'changePassword': () => Pager.changePassword,
    'changePhone': () => Pager.changePhone,
    'language': () => Pager.language,
    'myOrders': () => Pager.myOrders,
    'orderDetails': () => Pager.orderDetails(OrderModel.all[1]),
    'orderTracking': () => OrderTrackingPage(tileProvider: _NoNetworkTiles()),
    'deliveryAddress': () => Pager.deliveryAddress,
    'newAddress': () => Pager.newAddress(),
    'editAddress': () => Pager.newAddress(editIndex: 0),
    'notifications': () => Pager.notifications,
    'notificationSettings': () => Pager.notificationSettings,
    'offers': () => Pager.offers,
    'promos': () => Pager.promos,
    'couponDetails': () => Pager.couponDetails(CouponModel.demo.first),
    'main (profile tab reachable)': () => Pager.main,
  };
  for (final e in pages.entries) {
    testWidgets('${e.key} renders', (tester) async {
      await _pump(tester, e.value());
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('new address is saved and becomes the default', (tester) async {
    final addresses = AddressCubit();
    await _pump(tester, Pager.newAddress(), addresses: addresses);
    final fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), 'Jon Doril Parvin');
    await tester.enterText(fields.at(1), '+8801710000000');
    await tester.enterText(fields.at(2), 'Puraton Custom Road');
    await tester.enterText(fields.at(4), 'Chhatak');
    await tester.ensureVisible(find.text('Save Address'));
    await tester.tap(find.text('Save Address'));
    await tester.pump();
    expect(addresses.state.current!.title, 'Puraton Custom Road, Chhatak');
    expect(tester.takeException(), isNull);
  });

  testWidgets('my orders tabs filter running and previous', (tester) async {
    await _pump(tester, Pager.myOrders);
    await tester.tap(find.textContaining('Previous'));
    await tester.pumpAndSettle();
    expect(find.text('Confirmed'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('redeem applies the coupon to the cart', (tester) async {
    final cart = CartCubit();
    await _pump(tester, Pager.couponDetails(CouponModel.demo.first), cart: cart);
    await tester.tap(find.text('Redeem Now'));
    await tester.pump();
    expect(cart.state.discountRate, closeTo(0.41, 1e-9));
  });

  testWidgets('change password rejects a mismatch', (tester) async {
    await _pump(tester, Pager.changePassword);
    final fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), 'oldpass1');
    await tester.enterText(fields.at(1), 'newpass1');
    await tester.enterText(fields.at(2), 'different');
    await tester.tap(find.text('Update Password'));
    await tester.pump();
    expect(find.text('Passwords do not match'), findsOneWidget);
  });
}
