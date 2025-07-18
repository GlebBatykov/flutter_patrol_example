import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_example/ui/app.dart';
import 'package:patrol_example/ui/pages/fibonacci_page.dart';

void main() {
  patrolSetUp(() async {
    // Логика которая должна выполнятся перед каждым тестом
  });

  patrolTearDown(() {
    // Логика которая должна выполнятся после каждого теста
  });

  patrolTest('Test fibonacci page', (tester) async {
    // Подготавливаем приложение.
    await tester.pumpWidgetAndSettle(const App());

    // Переходим на нужную страницу.
    await tester('Fibonacci').tap();

    // Проверяем что результат на странице не вычислен,
    // это начальное состояние страницы.
    expect(tester('Don\'t have result').visible, isTrue);

    // Вводим число 20.
    await tester.enterText(
      tester(FibonacciPageKeys.textField),
      '20',
    );

    // Вычисляем результат.
    await tester('Calculate').tap();

    // Проверяем результат.
    expect(tester('Result: 6765').visible, isTrue);

    // Вводим число 10.
    await tester.enterText(
      tester(FibonacciPageKeys.textField),
      '10',
    );

    // Вычисляем результат.
    await tester('Calculate').tap();

    // Проверяем результат.
    expect(tester('Result: 55').visible, isTrue);
  });

  patrolTest(
    'Test browser page in Android',
    (tester) async {
      // Подготавливаем приложение.
      await tester.pumpWidgetAndSettle(const App());

      // Переходим на нужную страницу.
      await tester('Browser').tap();

      // Открываем ссылку в браузере.
      await tester('Open browser').tap();

      // Проверяем наличие текста при помощи waitUntilVisible.
      // Ожидаем текст, потому что нужно некоторое время для прогрузки
      // страницы в браузере.
      await tester.native2.waitUntilVisible(
        NativeSelector(
          android: AndroidSelector(text: 'Подборка для вас'),
        ),
      );

      // Нажимаем на системную кнопку назад.
      await tester.native2.pressBack();

      // Ожидаем следущий кадр в нашем Flutter приложении,
      // после того как мы закрыли браузер. Иначе будет черный экран.
      await tester.pumpAndTrySettle();

      // Проверяем что на экране снова отображается кнопка
      // с страницы браузера.
      expect(tester('Open browser').visible, isTrue);
    },
    skip: Platform.isIOS,
  );

  patrolTest(
    'Test notification page in Android',
    (tester) async {
      // Подготавливаем приложение.
      await tester.pumpWidgetAndSettle(const App());

      // Переходим на нужную страницу.
      await tester('Notification').tap();

      final getPermissionButtonFinder = tester('Get permission');

      if (getPermissionButtonFinder.visible) {
        // Проверяем что у на на странице находится кнопка с текстом
        // "Get permission", а так же нажимаем на нее.
        // В случае если кнопки с таким текстом не будет, тест завершится
        // с ошибкой.
        await getPermissionButtonFinder.tap();

        await tester.native2.grantPermissionWhenInUse();

        // Дожидаемся следующего кадра в Flutter приложении.
        await tester.pumpAndTrySettle(
          duration: const Duration(seconds: 1),
        );
      }

      // Проверяем что у на на странице находится кнопка с текстом
      // "Show notification", а так же нажимаем на нее.
      // В случае если кнопки с таким текстом не будет, тест завершится
      // с ошибкой.
      await tester('Show notification').tap();

      // Открываем системные уведомления.
      await tester.native2.openNotifications();

      // Получаем первое уведомление из списка. Оно же и является
      // последним добавленным уведомлением.
      final notification = await tester.native2.getFirstNotification();

      // Проверяем что уведомление содержит нужный заголовок.
      expect(notification.title, equals('Hello, from notification!'));

      // Закрываем системные уведомления. Это необходимо сделать
      // потому что автоматически между тестами, по умолчанию это не происходит.
      // Это нужно делать либо в конце теста,
      // либо использовать patrolTearDown/patrolSetUp функции.
      await tester.native2.closeNotifications();
    },
    skip: Platform.isIOS,
  );
}
