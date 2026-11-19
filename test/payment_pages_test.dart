import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grocery_app/common/cubits/address/address_cubit.dart';
import 'package:grocery_app/common/cubits/cart/cart_cubit.dart';
import 'package:grocery_app/core/constants/app_themes.dart';
import 'package:grocery_app/core/navigation/pager.dart';
import 'package:grocery_app/features/payment/pages/add_card_page.dart';
import 'package:grocery_app/features/payment/pages/payment_option_page.dart';
import 'package:grocery_app/features/payment/widgets/bank_card.dart';
import 'package:grocery_app/features/support/pages/menu_page.dart';

Future<void> _pump(WidgetTester tester, Widget page, {Size size = const Size(414, 896)}) async {
  tester.view
    ..physicalSize = size * 3
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
  for (final e in {'paymentOption': Pager.paymentOption, 'addCard': Pager.addCard}.entries) {
    testWidgets('${e.key} renders without overflow', (tester) async {
      await _pump(tester, e.value);
      expect(tester.takeException(), isNull);
    });
    testWidgets('${e.key} fits a 360 px phone', (tester) async {
      await _pump(tester, e.value, size: const Size(360, 640));
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('profile Payment row opens Payment Option', (tester) async {
    await _pump(tester, Pager.profile());
    await tester.ensureVisible(find.text('Payment'));
    await tester.tap(find.text('Payment'));
    await tester.pumpAndSettle();
    expect(find.byType(PaymentOptionPage), findsOneWidget);
  });

  testWidgets('profile menu button opens the Menu (drawer) page', (tester) async {
    await _pump(tester, Pager.profile());
    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();
    expect(find.byType(MenuPage), findsOneWidget);
  });

  testWidgets('Add Card validates, then adds the card to the list', (tester) async {
    await _pump(tester, Pager.paymentOption);
    expect(find.byType(BankCard), findsNWidgets(2));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    expect(find.byType(AddCardPage), findsOneWidget);

    await tester.ensureVisible(find.text('Add Card'));
    await tester.tap(find.text('Add Card'));
    await tester.pump();
    expect(find.text('This field is required'), findsWidgets);

    final fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), 'Jonny Alberto');
    await tester.enterText(fields.at(1), '4756 1234 5678 9018');
    await tester.enterText(fields.at(2), '13/24');
    await tester.enterText(fields.at(3), '123');
    await tester.ensureVisible(find.text('Add Card'));
    await tester.tap(find.text('Add Card'));
    await tester.pump();
    expect(find.text('Use MM/YY'), findsOneWidget);

    await tester.enterText(fields.at(2), '10/27');
    await tester.ensureVisible(find.text('Add Card'));
    await tester.tap(find.text('Add Card'));
    await tester.pumpAndSettle();
    expect(find.byType(PaymentOptionPage), findsOneWidget);
    expect(find.text('JONNY ALBERTO'), findsOneWidget);
    expect(find.text('Card added'), findsOneWidget);
  });
}
