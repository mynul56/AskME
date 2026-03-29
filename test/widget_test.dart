// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:aiask/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Splash flows to onboarding then home', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify splash is shown first.
    expect(find.text('Ethereal\nIntelligence'), findsOneWidget);

    // Wait for splash sequence to complete.
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    // Verify onboarding appears.
    expect(find.text('The Editorial'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Continue to home from onboarding.
    await tester.tap(find.byKey(const Key('onboarding_get_started')));
    await tester.pumpAndSettle();

    // Verify that home screen and counter are shown.
    expect(find.text('HomeView'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
