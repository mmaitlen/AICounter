import 'package:aicounter/features/counter/data/datasources/counter_local_data_source.dart';
import 'package:aicounter/features/counter/domain/entities/counter.dart';
import 'package:aicounter/features/counter/domain/repositories/counter_repository.dart';

class CounterRepositoryImpl implements CounterRepository {
  final CounterLocalDataSource localDataSource;

  CounterRepositoryImpl({required this.localDataSource});

  @override
  Future<Counter> getCounter() {
    return localDataSource.getCounter();
  }

  @override
  Future<void> setCounter(Counter counter) {
    return localDataSource.setCounter(counter);
  }
}
