import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:patrol_example/ui/app.dart';
import 'package:patrol_example/ui/keys.dart';
import 'package:patrol_example/ui/pages/counter_page.dart';
import 'package:patrol_example/ui/pages/fibonacci_page.dart';

void main() {
  patrolSetUp(() {});

  patrolTearDown(() {});

  patrolTest('Test counter page', ($) async {
    await $.pumpWidgetAndSettle(const App());

    await $('Counter').tap();

    expect($('0').visible, isTrue);

    await $(CounterPageKeys.incrementButton).tap();

    expect($('1').visible, isTrue);

    for (var i = 0; i < 5; i++) {
      await $(CounterPageKeys.incrementButton).tap();
    }

    expect($('6').visible, isTrue);
  });

  patrolTest('Test fibonacci page', ($) async {
    await $.pumpWidgetAndSettle(const App());

    await $('Fibonacci').tap();

    expect($('Don\'t have result').visible, isTrue);

    await $.enterText($(FibonacciPageKeys.textField), '20');

    await $('Calculate').tap();

    expect($('Result: 6765').visible, isTrue);

    await $.enterText($(FibonacciPageKeys.textField), '10');

    await $('Calculate').tap();

    expect($('Result: 55').visible, isTrue);
  });

  patrolTest(
    'Test press back page in Android',
    ($) async {
      await $.pumpWidgetAndSettle(const App());

      await $('Press back').tap();

      await $.native2.pressBack();
      await $.pumpAndTrySettle();

      expect($('Close the page?').visible, isTrue);

      await $('Cancel').tap();

      await $.native2.pressBack();
      await $.pumpAndTrySettle();

      expect($('Close the page?').visible, isTrue);

      await $('Close page').tap();

      await $.native2.pressBack();
      await $.pumpAndTrySettle();

      expect($('Select page').visible, isTrue);
    },
    skip: Platform.isIOS,
  );

  patrolTest(
    'Test press back page in iOS',
    ($) async {
      await $.pumpWidgetAndSettle(const App());

      await $('Press back').tap();

      await $(Keys.backButton).tap();

      expect($('Close the page?').visible, isTrue);

      await $('Cancel').tap();

      await $(Keys.backButton).tap();

      expect($('Close the page?').visible, isTrue);

      await $('Close page').tap();

      await $(Keys.backButton).tap();

      expect($('Select page').visible, isTrue);
    },
    skip: Platform.isAndroid,
  );

  patrolTest('Test permission page', ($) async {
    await $.pumpWidgetAndSettle(const App());

    await $('Permission').tap();

    expect($('Don\'t have permission').visible, isTrue);

    await $('Get permission').tap();

    await $.native2.grantPermissionWhenInUse();
    await $.pumpAndTrySettle();

    expect($('Have permission').visible, isTrue);
  });

  patrolTest(
    'Test browser page in Android',
    ($) async {
      await $.pumpWidgetAndSettle(const App());

      await $('Browser').tap();

      await $('Open browser').tap();

      await $.native2.waitUntilVisible(
        NativeSelector(
          android: AndroidSelector(text: 'Подборка для вас'),
        ),
        timeout: const Duration(seconds: 5),
      );

      await $.native2.pressBack();
      await $.pumpAndTrySettle();

      expect($('Open browser').visible, isTrue);
    },
    skip: Platform.isIOS,
  );

  patrolTest('Test notification page', ($) async {
    await $.pumpWidgetAndSettle(const App());

    await $('Notification').tap();

    await $('Get permission').tap();

    await $.native2.grantPermissionWhenInUse();
    await $.pumpAndTrySettle();

    await $('Show notification').tap();

    await $.native2.openNotifications();

    final notification = await $.native2.getFirstNotification();

    expect(notification.title, equals('Hello, from notification!'));
  });
}
