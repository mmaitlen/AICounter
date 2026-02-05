part of 'counter_bloc.dart';

enum CounterStatus { initial, loading, success, failure }

class CounterState extends Equatable {
  const CounterState({
    this.status = CounterStatus.initial,
    this.counter = 0,
    this.step = 1,
  });

  final CounterStatus status;
  final int counter;
  final int step;

  CounterState copyWith({
    CounterStatus? status,
    int? counter,
    int? step,
  }) {
    return CounterState(
      status: status ?? this.status,
      counter: counter ?? this.counter,
      step: step ?? this.step,
    );
  }

  @override
  List<Object> get props => [status, counter, step];
}
