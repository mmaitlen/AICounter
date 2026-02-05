import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aicounter/features/counter/data/datasources/counter_local_data_source.dart';
import 'package:aicounter/features/counter/data/repositories/counter_repository_impl.dart';
import 'package:aicounter/features/counter/domain/repositories/counter_repository.dart';
import 'package:aicounter/features/counter/domain/usecases/decrement_counter.dart';
import 'package:aicounter/features/counter/domain/usecases/increment_counter.dart';
import 'package:aicounter/features/counter/domain/usecases/get_counter.dart';
import 'package:aicounter/features/counter/presentation/bloc/counter_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(
    () => CounterBloc(
      getCounter: sl(),
      incrementCounter: sl(),
      decrementCounter: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => GetCounter(sl()));
  sl.registerLazySingleton(() => IncrementCounter(sl()));
  sl.registerLazySingleton(() => DecrementCounter(sl()));

  // Repositories
  sl.registerLazySingleton<CounterRepository>(
    () => CounterRepositoryImpl(localDataSource: sl()),
  );

  // Datasources
  sl.registerLazySingleton<CounterLocalDataSource>(
    () => CounterLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
