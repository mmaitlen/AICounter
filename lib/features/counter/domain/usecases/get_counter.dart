import 'package:aicounter/features/counter/domain/entities/counter.dart';
import 'package:aicounter/features/counter/domain/repositories/counter_repository.dart';

class GetCounter {
  final CounterRepository repository;

  GetCounter(this.repository);

  Future<Counter> call() async {
    return await repository.getCounter();
  }
}
