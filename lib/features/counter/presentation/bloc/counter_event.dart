part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}

class CounterIncremented extends CounterEvent {}

class CounterDecremented extends CounterEvent {}

class CounterStepChanged extends CounterEvent {
  final int step;

  CounterStepChanged(this.step);
}

class CounterLoaded extends CounterEvent {}
