import 'package:patrol/patrol.dart';

import 'features/browser_page_injector.dart';
import 'features/fibonacci_page_injector.dart';
import 'features/notificaton_page_injector.dart';

import 'test_injector.dart';

const _injectors = <TestInjector>[
  BrowserPageTestInjector(),
  FibonacciPageTestInjector(),
  NotificationPageTestInjector(),
];

void main() {
  patrolSetUp(() async {
    // Логика которая должна выполнятся перед каждым тестом
  });

  patrolTearDown(() {
    // Логика которая должна выполнятся после каждого теста
  });

  for (final injector in _injectors) {
    injector.inject();
  }
}
