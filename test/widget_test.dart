import 'package:flutter_test/flutter_test.dart';

import 'package:campuseats_frontend/main.dart';

void main() {
  testWidgets('Campus Eats splash screen smoke test', (WidgetTester tester) async {
    // Build our Campus Eats app and trigger a frame.
    await tester.pumpWidget(const CampusEatsApp());

    // Verify that the app displays the splash screen title correctly.
    expect(find.text('Campus Eats'), findsOneWidget);
    expect(find.text('Smart Campus Food Delivery'), findsOneWidget);
  });
}