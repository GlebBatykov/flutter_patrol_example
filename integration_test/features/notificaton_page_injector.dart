import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_example/ui/app.dart';

import '../test_injector.dart';

class NotificationPageTestInjector implements TestInjector {
  const NotificationPageTestInjector();

  @override
  void inject() {
    patrolTest(
      'Test notification page',
      ($) async {
        // Подготавливаем приложение.
        await $.pumpWidgetAndSettle(const App());

        // Переходим на нужную страницу.
        await $('Notification').tap();

        final getPermissionButtonFinder = $('Get permission');

        if (getPermissionButtonFinder.visible) {
          // Проверяем что у на на странице находится кнопка с текстом
          // "Get permission", а так же нажимаем на нее.
          // В случае если кнопки с таким текстом не будет, тест завершится
          // с ошибкой.
          await getPermissionButtonFinder.tap();

          await $.native2.grantPermissionWhenInUse();

          // Дожидаемся следующего кадра в Flutter приложении.
          await $.pumpAndTrySettle(
            duration: const Duration(seconds: 1),
          );
        }

        // Проверяем что у на на странице находится кнопка с текстом
        // "Show notification", а так же нажимаем на нее.
        // В случае если кнопки с таким текстом не будет, тест завершится
        // с ошибкой.
        await $('Show notification').tap();

        // Открываем системные уведомления.
        await $.native2.openNotifications();

        // Получаем первое уведомление из списка. Оно же и является
        // последним добавленным уведомлением.
        final notification = await $.native2.getFirstNotification();

        // Проверяем что уведомление содержит нужный заголовок.
        expect(notification.title, equals('Hello, from notification!'));

        // Закрываем системные уведомления. Это необходимо сделать
        // потому что автоматически между тестами, по умолчанию это не происходит.
        // Это нужно делать либо в конце теста,
        // либо использовать patrolTearDown/patrolSetUp функции.
        await $.native2.closeNotifications();
      },
      skip: Platform.isIOS,
    );
  }
}
