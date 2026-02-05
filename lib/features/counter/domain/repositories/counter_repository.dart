import 'package:aicounter/features/counter/domain/entities/counter.dart';

abstract class CounterRepository {
  Future<Counter> getCounter();
  Future<void> setCounter(Counter counter);
}
