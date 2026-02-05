import 'package:aicounter/features/counter/domain/entities/counter.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CounterLocalDataSource {
  Future<Counter> getCounter();
  Future<void> setCounter(Counter counter);
  Future<int> getStep();
  Future<void> setStep(int step);
}

class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CounterLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Counter> getCounter() async {
    final counterValue = sharedPreferences.getInt('counter');
    return Counter(counterValue ?? 0);
  }

  @override
  Future<void> setCounter(Counter counter) async {
    await sharedPreferences.setInt('counter', counter.value);
  }

  @override
  Future<int> getStep() async {
    final stepValue = sharedPreferences.getInt('step');
    return stepValue ?? 1;
  }

  @override
  Future<void> setStep(int step) async {
    await sharedPreferences.setInt('step', step);
  }
}
