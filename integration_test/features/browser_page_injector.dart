import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_example/ui/app.dart';

import '../test_injector.dart';

class BrowserPageTestInjector implements TestInjector {
  static const String _text = 'Подборка для вас';

  const BrowserPageTestInjector();

  @override
  void inject() {
    patrolTest(
      'Test browser page in Android',
      ($) async {
        // Подготавливаем приложение.
        await $.pumpWidgetAndSettle(const App());

        // Переходим на нужную страницу.
        await $('Browser').tap();

        // Открываем ссылку в браузере.
        await $('Open browser').tap();

        // Проверяем наличие текста при помощи waitUntilVisible.
        // Ожидаем текст, потому что нужно некоторое время для прогрузки
        // страницы в браузере.
        await $.native2.waitUntilVisible(
          NativeSelector(
            android: AndroidSelector(text: _text),
          ),
        );

        // Нажимаем на системную кнопку назад.
        await $.native2.pressBack();

        // Ожидаем следущий кадр в нашем Flutter приложении,
        // после того как мы закрыли браузер. Иначе будет черный экран.
        await $.pumpAndTrySettle();

        // Проверяем что на экране снова отображается кнопка
        // с страницы браузера.
        expect($('Open browser').visible, isTrue);
      },
      skip: Platform.isIOS,
    );

    patrolTest(
      'Test browser page in IOS',
      ($) async {
        // Подготавливаем приложение
        await $.pumpWidgetAndSettle(const App());

        // Переходим на нужную страницу
        await $('Browser').tap();

        // Открываем ссылку в браузере
        await $('Open browser').tap();

        // Проверяем наличие текста при помощи waitUntilVisible.
        // Ожидаем текст, потому что нужно некоторое время для прогрузки
        // страницы в браузере.
        await $.native2.waitUntilVisible(
          NativeSelector(
            ios: IOSSelector(value: _text),
          ),
        );

        // Нажимает на кнопку "Done" в браузере
        await $.native2.tapAt(
          const Offset(0.1, 0.1),
        );

        // Ожидаем следущий кадр в нашем Flutter приложении,
        // после того как мы закрыли браузер. Иначе будет черный экран.
        await $.pumpAndTrySettle();

        // Проверяем что на экране снова отображается кнопка
        // с страницы браузера.
        expect($('Open browser').visible, isTrue);
      },
      skip: Platform.isAndroid,
    );
  }
}
