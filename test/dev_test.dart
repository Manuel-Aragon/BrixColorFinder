//This contains the test for the register.dart page

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucky13capstone/dev_page.dart';

void main() {
  testWidgets('', (WidgetTester tester) async {
    Widget testWidget = const MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(home: DevPage(title: 'Dev Page')));
    // Build our app and trigger a frame.
    await tester.pumpWidget(testWidget);
    // Tap on the "Login" button
    //await tester.tap(find.text('Login'));
    //await tester.pumpAndSettle();
  });
}
