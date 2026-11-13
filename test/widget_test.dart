import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:grocery_app/core/constants/app_durations.dart';
import 'package:grocery_app/features/onboarding/pages/onboarding_page.dart';
import 'package:grocery_app/features/splash/pages/splash_page.dart';
import 'package:grocery_app/main.dart';

void main() {
  testWidgets('splash opens onboarding', (tester) async {
    tester.view
      ..physicalSize = const Size(1242, 2688) // 414 x 896 @3x
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const GroceryApp());
    await tester.pump();
    expect(find.byType(SplashPage), findsOneWidget);

    await tester.pump(AppDurations.splash);
    await tester.pumpAndSettle();
    expect(find.byType(OnboardingPage), findsOneWidget);
  });
}
