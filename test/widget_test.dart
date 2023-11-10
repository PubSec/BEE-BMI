// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beebmicalculator/main.dart';

void main() {
  testWidgets('BMI Calculator', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Tap on the info icon to show a dialog
    await tester.tap(find.byIcon(Icons.info_outline_rounded));
    await tester.pump();

    // Verify that the texts that show the weight and height are empty
    expect(find.text(''), findsWidgets);
  });
}
