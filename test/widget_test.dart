import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:askme/main.dart';

void main() {
  tearDown(() => Get.reset());

  testWidgets('Welcome screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CognitiveSanctuaryApp());
    await tester.pumpAndSettle();

    // The welcome screen should contain the headline text
    expect(find.text('Get Started →'), findsOneWidget);
  });
}
