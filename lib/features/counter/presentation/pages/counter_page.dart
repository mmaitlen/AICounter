import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:aicounter/features/counter/presentation/signals/counter_signals.dart';
import 'package:aicounter/features/counter/domain/usecases/get_counter.dart';
import 'package:aicounter/features/counter/domain/usecases/increment_counter.dart';
import 'package:aicounter/features/counter/domain/usecases/decrement_counter.dart';
import 'package:aicounter/core/dependency_injection.dart' as di;

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final GetCounter getCounter = di.sl<GetCounter>();
  final IncrementCounter incrementCounter = di.sl<IncrementCounter>();
  final DecrementCounter decrementCounter = di.sl<DecrementCounter>();

  @override
  void initState() {
    super.initState();
    _loadCounterAndStep();
  }

  Future<void> _loadCounterAndStep() async {
    final c = await getCounter();
    counter.value = c.value;
    // We need to fetch the step value from the repository too
    // For now, it's implicitly handled by the initial value of the signal
    // Once we add a GetStep use case, we'll use it here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Step'),
                onChanged: (value) {
                  final parsedValue = int.tryParse(value);
                  if (parsedValue != null) {
                    step.value = parsedValue;
                    // Save step value
                    // This will be handled by a SetStep use case later
                  }
                },
                controller: TextEditingController(text: step.value.toString()), // Initialize with current step value
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // Watch the counter signal for changes
            Watch((context) {
              return Text(
                '$counter',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await incrementCounter(step.value);
              _loadCounterAndStep(); // Reload counter after increment
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () async {
              await decrementCounter(step.value);
              _loadCounterAndStep(); // Reload counter after decrement
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
