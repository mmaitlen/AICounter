import 'package:aicounter/features/counter/data/datasources/counter_local_data_source.dart';
import 'package:aicounter/features/counter/data/repositories/counter_repository_impl.dart';
import 'package:aicounter/features/counter/domain/entities/counter.dart';
import 'package:aicounter/features/counter/domain/usecases/decrement_counter.dart';
import 'package:aicounter/features/counter/domain/usecases/get_counter.dart';
import 'package:aicounter/features/counter/domain/usecases/increment_counter.dart';
import 'package:aicounter/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStore extends Mock implements CounterLocalDataSource {}

void main() {
  late MockStore mockStore;
  late CounterRepositoryImpl repo;
  late GetCounter fetchCount;
  late IncrementCounter incCount;
  late DecrementCounter decCount;
  late CounterBloc bloc;

  group('CounterBloc Tests', () {

    mockStore = MockStore();
    repo = CounterRepositoryImpl(localDataSource: mockStore);
    fetchCount = GetCounter(repo);
    incCount = IncrementCounter(repo);
    decCount = DecrementCounter(repo);
    bloc = CounterBloc(getCounter: fetchCount, incrementCounter: incCount, decrementCounter: decCount);

    when(() => mockStore.getCounter()).thenAnswer((_) async =>  Counter(5));

    blocTest<CounterBloc, CounterState>(
      'emits [Loading, Loaded] when LoadDataEvent is added',
      build: () => bloc,
      act: (bloc) => bloc.add(CounterLoaded()),
      expect: () => [
        isA<CounterState>().having((state) => state.counter, 'data', 0),
        isA<CounterState>().having((state) => state.counter, 'data', 5),
      ],
      verify: (_) {
        verify(() => repo.getCounter()).called(1);
      },
    );
  });
}