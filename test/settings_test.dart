//This contains the test for the register.dart page

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucky13capstone/register_page.dart';

void main() {
  testWidgets('', (WidgetTester tester) async {
    //Wrap signuppage widget with the MediaQuery(...) instance due to Scaffold(..)
    Widget testWidget = const MediaQuery(
        data: MediaQueryData(), child: MaterialApp(home: SignUpPage()));
    // Build our app and trigger a frame.
    await tester.pumpWidget(testWidget);

    // Verify that our counter starts at 0.
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
