import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_motion_ui/flutter_motion_ui.dart';

void main() {
  testWidgets('MotionButton renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MotionButton(
            onPressed: () {},
            child: const Text('Test Button'),
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);
  });
}