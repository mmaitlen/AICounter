import 'package:aicounter/features/counter/domain/entities/counter.dart';
import 'package:aicounter/features/counter/domain/repositories/counter_repository.dart';

class DecrementCounter {
  final CounterRepository repository;

  DecrementCounter(this.repository);

  Future<void> call(int step) async {
    final currentCounter = await repository.getCounter();
    final newCounter = Counter(currentCounter.value - step);
    await repository.setCounter(newCounter);
  }
}
