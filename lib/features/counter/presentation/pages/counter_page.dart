import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aicounter/features/counter/presentation/bloc/counter_bloc.dart';
import 'package:aicounter/core/dependency_injection.dart' as di;

class CounterPage extends StatelessWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<CounterBloc>()..add(CounterLoaded()),
      child: CounterView(title: title),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: const Text('Settings'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Step'),
                    onChanged: (value) {
                      final parsedValue = int.tryParse(value);
                      if (parsedValue != null) {
                        context.read<CounterBloc>().add(
                          CounterStepChanged(parsedValue),
                        );
                      }
                    },
                    controller: TextEditingController(
                      text: state.step.toString(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text('Counter value is:'),
            ),
            BlocSelector<CounterBloc, CounterState, int>(
              selector: (state) => state.counter,
              builder: (context, counter) {
                final status = context.select(
                  (CounterBloc bloc) => bloc.state.status,
                );
                if (status == CounterStatus.loading) {
                  return const CircularProgressIndicator();
                }
                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () =>
                context.read<CounterBloc>().add(CounterIncremented()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () =>
                context.read<CounterBloc>().add(CounterDecremented()),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
