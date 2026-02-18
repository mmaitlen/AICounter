import 'package:aicounter/features/counter/domain/entities/counter.dart';
import 'package:aicounter/features/counter/domain/repositories/counter_repository.dart';
import 'package:aicounter/features/counter/domain/usecases/increment_counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Ensure inc behaves as expected", () async {
    final mockRepo = MockRepo();
    final incCounter = IncrementCounter(mockRepo);

    await incCounter.call(2);
  });
}

class MockRepo extends CounterRepository {
  @override
  Future<Counter> getCounter() async {
    return Counter(3);
  }

  @override
  Future<void> setCounter(Counter counter) async {
    expect(counter.value, 5);
  }
}
