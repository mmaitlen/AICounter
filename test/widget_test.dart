import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aicounter/main.dart';
import 'package:aicounter/core/dependency_injection.dart' as di;
import 'package:aicounter/features/counter/presentation/signals/counter_signals.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await di.sl.reset(); // Reset GetIt before initializing
    await di.init(); // Initialize GetIt with fresh mocks
    counter.value = 0;
    step.value = 1;
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Counter decrements smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '-' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    // Verify that our counter has decremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('-1'), findsOneWidget);
  });

  testWidgets('Change step value', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Open the drawer.
    final ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    // Find the text field.
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    // Enter a new step value.
    await tester.enterText(textField, '5');
    await tester.pump();

    // Close the drawer by swiping it back.
    await tester.drag(find.byType(Drawer), const Offset(-300, 0));
    await tester.pumpAndSettle();

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that our counter has incremented by 5.
    expect(find.text('5'), findsOneWidget);

    // Tap the '-' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    // Verify that our counter has decremented by 5.
    expect(find.text('0'), findsOneWidget);
  });
}
