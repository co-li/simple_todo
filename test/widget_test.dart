// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_todo/main.dart';

void main() {
  group('Widget Tests', () {
    testWidgets('Navigation Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      final titleFinder = find.text('To Do List');
      final addFinder = find.text('Add To Do');
      final editFinder = find.text('Edit To Do');

      expect(titleFinder, findsOneWidget);
      expect(addFinder, findsNothing);
      expect(editFinder, findsNothing);

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      expect(titleFinder, findsNothing);
      expect(addFinder, findsOneWidget);
      expect(editFinder, findsNothing);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(addFinder, findsNothing);
      expect(editFinder, findsNothing);

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      expect(titleFinder, findsNothing);
      expect(addFinder, findsNothing);
      expect(editFinder, findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(addFinder, findsNothing);
      expect(editFinder, findsNothing);
    });
    testWidgets('Add and Remove To Do Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      final titleFinder = find.text('To Do List');

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "item 1");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(find.text("item 1"), findsOneWidget);
      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, false);

      await tester.tap(find.text("item 1"));
      await tester.pump();

      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, true);

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(find.text("item 1"), findsNothing);
    });
    testWidgets('Edit To Do Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      final titleFinder = find.text('To Do List');

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "item 1");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(find.text("item 1"), findsOneWidget);
      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, false);

      await tester.tap(find.text("item 1"));
      await tester.pump();

      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, true);

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "item 2");
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(tester.widget<Checkbox>(find.byType(Checkbox)).value, true);
      expect(find.text("item 2"), findsOneWidget);
    });
    testWidgets('Reorder To Do Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      final titleFinder = find.text('To Do List');
      final originalList = ["item 1", "item 2"];

      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "item 1");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), "item 2");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();

      expect(titleFinder, findsOneWidget);
      expect(tester.widget<Text>(find.byType(Text).first).data, "item 1");

      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      final TestGesture drag =
          await tester.startGesture(tester.getCenter(find.byIcon(Icons.drag_handle).first));
      await tester.pump(kLongPressTimeout + kPressTimeout);
      await drag.moveTo(tester.getCenter(find.byIcon(Icons.drag_handle).last) + const Offset(0, 500));
      await tester.pump(kPressTimeout);
      await drag.up();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();

      expect(tester.widget<Text>(find.byType(Text).first).data, "item 2");
    });
  });
}
