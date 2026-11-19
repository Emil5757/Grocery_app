import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grocery_app/common/cubits/address/address_cubit.dart';
import 'package:grocery_app/common/cubits/cart/cart_cubit.dart';
import 'package:grocery_app/common/cubits/review/review_cubit.dart';
import 'package:grocery_app/common/cubits/search_history/search_history_cubit.dart';
import 'package:grocery_app/common/cubits/user/user_cubit.dart';
import 'package:grocery_app/common/data/category_data.dart';
import 'package:grocery_app/common/data/pack_data.dart';
import 'package:grocery_app/common/data/product_data.dart';
import 'package:grocery_app/common/data/user_data.dart';
import 'package:grocery_app/common/models/category_model.dart';
import 'package:grocery_app/core/constants/app_themes.dart';
import 'package:grocery_app/core/navigation/pager.dart';
import 'package:grocery_app/features/profile/pages/profile_photo_page.dart';

/// 1x1 transparent PNG used as a "picked" photo.
final _png = Uint8List.fromList(const [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4,
  0x89, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE,
  0x42, 0x60, 0x82,
]);

Future<void> _pump(WidgetTester tester, Widget page, UserCubit user) async {
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
          BlocProvider.value(value: user),
          BlocProvider(create: (_) => ReviewCubit()),
          BlocProvider(create: (_) => SearchHistoryCubit()),
        ],
        child: MaterialApp(theme: AppThemes.light, home: page),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  group('mock catalogue', () {
    test('every shelf category has products and every product has a category', () {
      for (final c in CategoryData.shelves) {
        expect(ProductData.byCategory(c.type), isNotEmpty, reason: c.name);
      }
      expect(CategoryData.shelves.any((c) => c.type == CategoryType.pack), isFalse);
      expect(ProductData.all.map((p) => p.id).toSet().length, ProductData.all.length,
          reason: 'product ids must be unique');
    });

    test('every product and pack image exists on disk', () {
      final images = {
        for (final p in ProductData.all) p.image,
        for (final p in PackData.popular) p.image,
        for (final p in PackData.homePacks) p.image,
      };
      final missing = images.where((path) => !File(path).existsSync()).toList();
      expect(missing, isEmpty);
    });

    test('search is case-insensitive and can be limited to a shelf', () {
      expect(ProductData.search('TOMATO').map((p) => p.id), ['tomato']);
      final gym = ProductData.byCategory(CategoryType.gym);
      expect(ProductData.search('vinyl', from: gym).single.id, 'vinyl_dumbbells');
      expect(ProductData.search('tomato', from: gym), isEmpty);
      expect(ProductData.search('  ').length, ProductData.all.length);
    });
  });

  group('UserCubit', () {
    test('updates info, phone and photo, and reset restores the mock user', () {
      final c = UserCubit()
        ..updateInfo(firstName: ' Jonny ', lastName: 'Albas', gender: 'Male', birthday: '01.02.1999')
        ..updatePhone('+8801800000000')
        ..setPhoto(_png);
      expect(c.state.fullName, 'Jonny Albas');
      expect(c.state.phone, '+8801800000000');
      expect(c.state.photo, isNotNull);
      expect(c.state.id, UserData.demo.id);
      c.removePhoto();
      expect(c.state.photo, isNull);
      c.reset();
      expect(c.state.fullName, UserData.demo.fullName);
    });
  });

  testWidgets('Edit Profile saves to the cubit and Profile shows it', (tester) async {
    final user = UserCubit();
    await _pump(tester, Pager.editProfile, user);
    final fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), 'Jonny');
    await tester.enterText(fields.at(1), 'Albas');
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(user.state.fullName, 'Jonny Albas');

    await _pump(tester, Pager.profile(), user);
    expect(find.text('Jonny Albas'), findsOneWidget);
  });

  testWidgets('Change Phone updates the user', (tester) async {
    final user = UserCubit();
    await _pump(tester, Pager.changePhone, user);
    final fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), '+8801711111111');
    await tester.enterText(fields.at(1), '+8801711111111');
    await tester.tap(find.text('Update Phone Number'));
    await tester.pump();
    expect(user.state.phone, '+8801711111111');
  });

  testWidgets('profile camera badge opens Profile Photo', (tester) async {
    await _pump(tester, Pager.profile(), UserCubit());
    await tester.tap(find.byIcon(Icons.camera_alt_outlined));
    await tester.pumpAndSettle();
    expect(find.byType(ProfilePhotoPage), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Profile Photo: Save is off until something changes; Remove + Save clears it', (tester) async {
    final user = UserCubit()..setPhoto(_png);
    await _pump(tester, Pager.profilePhoto, user);
    expect(tester.takeException(), isNull);

    final save = find.widgetWithText(InkWell, 'Save');
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(save, warnIfMissed: false);
    await tester.pump();
    expect(user.state.photo, isNotNull, reason: 'nothing changed yet');

    await tester.ensureVisible(find.text('Remove Photo'));
    await tester.tap(find.text('Remove Photo'));
    await tester.pump();
    await tester.ensureVisible(find.text('Save'));
    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(user.state.photo, isNull);
  });

  for (final c in CategoryData.shelves) {
    testWidgets('${c.name} products render', (tester) async {
      await _pump(tester, Pager.categoryProducts(c), UserCubit());
      expect(find.text(ProductData.byCategory(c.type).first.name), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('search result filters the catalogue', (tester) async {
    await _pump(tester, Pager.searchResult('glasses'), UserCubit());
    expect(find.text('4 Products Found'), findsOneWidget);
  });
}
