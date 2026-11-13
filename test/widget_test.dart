import 'package:flutter_test/flutter_test.dart';

import 'package:grocery_app/main.dart';

void main() {
  testWidgets('app boots', (tester) async {
    await tester.pumpWidget(const GroceryApp());
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
