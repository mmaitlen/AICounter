import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:aicounter/features/counter/domain/usecases/get_counter.dart';
import 'package:aicounter/features/counter/domain/usecases/increment_counter.dart';
import 'package:aicounter/features/counter/domain/usecases/decrement_counter.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  final GetCounter getCounter;
  final IncrementCounter incrementCounter;
  final DecrementCounter decrementCounter;

  CounterBloc({
    required this.getCounter,
    required this.incrementCounter,
    required this.decrementCounter,
  }) : super(const CounterState()) {
    on<CounterLoaded>(_onCounterLoaded);
    on<CounterIncremented>(_onCounterIncremented);
    on<CounterDecremented>(_onCounterDecremented);
    on<CounterStepChanged>(_onCounterStepChanged);
  }

  Future<void> _onCounterLoaded(
    CounterLoaded event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(status: CounterStatus.loading));
    try {
      final counter = await getCounter();
      emit(state.copyWith(
        status: CounterStatus.success,
        counter: counter.value,
      ));
    } catch (_) {
      emit(state.copyWith(status: CounterStatus.failure));
    }
  }

  Future<void> _onCounterIncremented(
    CounterIncremented event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(status: CounterStatus.loading));
    try {
      await incrementCounter(state.step);
      final counter = await getCounter();
      emit(state.copyWith(
        status: CounterStatus.success,
        counter: counter.value,
      ));
    } catch (_) {
      emit(state.copyWith(status: CounterStatus.failure));
    }
  }

  Future<void> _onCounterDecremented(
    CounterDecremented event,
    Emitter<CounterState> emit,
  ) async {
    emit(state.copyWith(status: CounterStatus.loading));
    try {
      await decrementCounter(state.step);
      final counter = await getCounter();
      emit(state.copyWith(
        status: CounterStatus.success,
        counter: counter.value,
      ));
    } catch (_) {
      emit(state.copyWith(status: CounterStatus.failure));
    }
  }

  void _onCounterStepChanged(
    CounterStepChanged event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(step: event.step));
  }
}
