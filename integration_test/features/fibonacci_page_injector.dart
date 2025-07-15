import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_example/ui/app.dart';
import 'package:patrol_example/ui/pages/fibonacci_page.dart';

import '../test_injector.dart';

class FibonacciPageTestInjector implements TestInjector {
  const FibonacciPageTestInjector();

  @override
  void inject() {
    patrolTest('Test fibonacci page', ($) async {
      // Подготоваливаем приложение.
      await $.pumpWidgetAndSettle(const App());

      // Переходим на нужную страницу.
      await $('Fibonacci').tap();

      // Проверяем что результат на странице не вычислен,
      // это начальное состояние страницы.
      expect($('Don\'t have result').visible, isTrue);

      // Вводим число 20.
      await $.enterText($(FibonacciPageKeys.textField), '20');

      // Вычисляем результат.
      await $('Calculate').tap();

      // Проверяем результат.
      expect($('Result: 6765').visible, isTrue);

      // Вводим число 10.
      await $.enterText($(FibonacciPageKeys.textField), '10');

      // Вычисляем результат.
      await $('Calculate').tap();

      // Проверяем результат.
      expect($('Result: 55').visible, isTrue);
    });
  }
}
