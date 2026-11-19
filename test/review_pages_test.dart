import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grocery_app/common/cubits/address/address_cubit.dart';
import 'package:grocery_app/common/cubits/cart/cart_cubit.dart';
import 'package:grocery_app/core/constants/app_themes.dart';
import 'package:grocery_app/core/navigation/pager.dart';

Future<void> _pump(WidgetTester tester, Widget page) async {
  tester.view
    ..physicalSize = const Size(1242, 2688) // 414 x 896 @3x
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, _) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider(create: (_) => AddressCubit()),
        ],
        child: MaterialApp(theme: AppThemes.light, home: page),
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  final pages = <String, Widget Function()>{
    'review': () => Pager.review,
    'submitReview': () => Pager.submitReview,
    'delivered': () => Pager.delivered,
    'error': () => Pager.error(),
  };
  for (final e in pages.entries) {
    testWidgets('${e.key} renders', (tester) async {
      await _pump(tester, e.value());
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('submit review needs a rating first', (tester) async {
    await _pump(tester, Pager.submitReview);
    await tester.ensureVisible(find.text('Submit'));
    await tester.tap(find.text('Submit'));
    await tester.pump();
    expect(find.text('Tap a star to rate the product'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('liking a review toggles its count', (tester) async {
    await _pump(tester, Pager.review);
    // The first review starts liked: 24 + 1.
    expect(find.text('25 Like'), findsOneWidget);
    await tester.ensureVisible(find.text('25 Like'));
    await tester.pump();
    await tester.tap(find.text('25 Like'));
    await tester.pump();
    expect(find.text('25 Like'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('review header fits a narrow 360 px phone', (tester) async {
    await _pump(tester, Pager.review);
    tester.view
      ..physicalSize = const Size(1080, 1920) // 360 x 640 @3x
      ..devicePixelRatio = 3;
    await tester.pump();
    expect(find.text('320 reviews'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('"Other" category dots keep their natural size', (tester) async {
    await _pump(tester, Pager.category);
    final dots = tester.elementList(find.byType(SvgPicture)).firstWhere(
      (e) => ((e.widget as SvgPicture).bytesLoader as SvgAssetLoader).assetName.contains('other'),
    );
    // Drawn at its natural 36 x 9 inside the 50 x 37 icon box, not stretched.
    expect((dots.widget as SvgPicture).fit, BoxFit.scaleDown);
    expect(dots.size!.width, lessThanOrEqualTo(50));
  });
}
