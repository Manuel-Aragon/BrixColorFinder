import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucky13capstone/brickview_page.dart';

void main() {
  testWidgets('BrickView builds correctly', (tester) async {
    // Build the BrickView widget
    Widget testWidget = const MediaQuery(
        data: MediaQueryData(), child: MaterialApp(home: BrickView()));
    // Build our app and trigger a frame.
    await tester.pumpWidget(testWidget);

    // Check that the Scaffold widget is present
    expect(find.byType(Scaffold), findsOneWidget);

    // Check that the AppBar widget is present
    expect(find.byType(AppBar), findsOneWidget);

    // Check that the Text widget with the correct title is present
    expect(find.text("BrickView"), findsOneWidget);
  });
}
