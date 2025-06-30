import 'package:flutter/material.dart';

import '../keys.dart';

abstract final class CounterPageKeys {
  static const ValueKey incrementButton = ValueKey('increment_button');
}

class CounterPage extends StatefulWidget {
  const CounterPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _CounterPage();
}

class _CounterPage extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Counter'),
          leading: const BackButton(
            key: Keys.backButton,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          key: CounterPageKeys.incrementButton,
          onPressed: _incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
}
