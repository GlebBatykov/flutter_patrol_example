import 'package:flutter/material.dart';

import '../keys.dart';

abstract final class FibonacciPageKeys {
  static const ValueKey textField = ValueKey('text_field');
}

class FibonacciPage extends StatefulWidget {
  const FibonacciPage({super.key});

  @override
  State<StatefulWidget> createState() => _FibonacciPageState();
}

class _FibonacciPageState extends State<FibonacciPage> {
  late final TextEditingController _textController = TextEditingController();

  int? _result;

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  void _calculate() {
    final text = _textController.text;

    if (text.isEmpty) {
      return;
    }

    final result = _fibonacci(int.parse(text));

    setState(() {
      _result = result;
    });
  }

  int _fibonacci(int number) => number == 0
      ? 1
      : number <= 2
          ? 1
          : _fibonacci(number - 1) + _fibonacci(number - 2);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fibonacci'),
        leading: const BackButton(
          key: Keys.backButton,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _result == null ? 'Don\'t have result' : 'Result: $_result',
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: size.width * 0.4,
              child: TextField(
                key: FibonacciPageKeys.textField,
                controller: _textController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}
