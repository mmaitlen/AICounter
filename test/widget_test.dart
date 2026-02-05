import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aicounter/features/counter/presentation/pages/counter_page.dart';
import 'package:aicounter/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterBloc extends MockBloc<CounterEvent, CounterState> implements CounterBloc {}

class FakeCounterEvent extends Fake implements CounterEvent {}

void main() {
  late MockCounterBloc mockCounterBloc;

  setUpAll(() {
    registerFallbackValue(FakeCounterEvent());
  });

  setUp(() {
    mockCounterBloc = MockCounterBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<CounterBloc>.value(
        value: mockCounterBloc,
        child: const CounterView(title: 'AICounter Home Page'),
      ),
    );
  }

  testWidgets('renders initial counter value', (WidgetTester tester) async {
    when(() => mockCounterBloc.state).thenReturn(const CounterState(counter: 0, status: CounterStatus.success));
    when(() => mockCounterBloc.stream).thenAnswer((_) => Stream.fromIterable([const CounterState(counter: 0, status: CounterStatus.success)]));
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('renders loading indicator when state is loading', (WidgetTester tester) async {
    when(() => mockCounterBloc.state).thenReturn(const CounterState(status: CounterStatus.loading));
    when(() => mockCounterBloc.stream).thenAnswer((_) => Stream.fromIterable([const CounterState(status: CounterStatus.loading)]));

    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('adds CounterIncremented event when increment button is tapped', (WidgetTester tester) async {
    when(() => mockCounterBloc.state).thenReturn(const CounterState(counter: 0, status: CounterStatus.success));
    when(() => mockCounterBloc.stream).thenAnswer((_) => Stream.fromIterable([const CounterState(counter: 0, status: CounterStatus.success)]));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byIcon(Icons.add));
    verify(() => mockCounterBloc.add(any(that: isA<CounterIncremented>()))).called(1);
  });

  testWidgets('adds CounterDecremented event when decrement button is tapped', (WidgetTester tester) async {
    when(() => mockCounterBloc.state).thenReturn(const CounterState(counter: 0, status: CounterStatus.success));
    when(() => mockCounterBloc.stream).thenAnswer((_) => Stream.fromIterable([const CounterState(counter: 0, status: CounterStatus.success)]));
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.tap(find.byIcon(Icons.remove));
    verify(() => mockCounterBloc.add(any(that: isA<CounterDecremented>()))).called(1);
  });

  testWidgets('adds CounterStepChanged event when text field is changed', (WidgetTester tester) async {
    when(() => mockCounterBloc.state).thenReturn(const CounterState(step: 1, status: CounterStatus.success));
    when(() => mockCounterBloc.stream).thenAnswer((_) => Stream.fromIterable([const CounterState(step: 1, status: CounterStatus.success)]));
    await tester.pumpWidget(createWidgetUnderTest());

    // Open the drawer
    final ScaffoldState scaffoldState = tester.firstState(find.byType(Scaffold));
    scaffoldState.openDrawer();
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '5');
    verify(() => mockCounterBloc.add(any(that: isA<CounterStepChanged>()))).called(1);
  });
}
