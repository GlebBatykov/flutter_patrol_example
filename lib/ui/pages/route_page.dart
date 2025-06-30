import 'package:flutter/material.dart';
import 'package:patrol_example/ui/pages/press_back_page.dart';

import 'browser_page.dart';
import 'counter_page.dart';
import 'fibonacci_page.dart';
import 'notification_page.dart';
import 'permission_page.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Select page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CounterPage(),
                    ),
                  );
                },
                child: const Text('Counter'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const FibonacciPage(),
                    ),
                  );
                },
                child: const Text('Fibonacci'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PressBackPage(),
                    ),
                  );
                },
                child: const Text('Press back'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const NotificationPage(),
                    ),
                  );
                },
                child: const Text('Notification'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const BrowserPage(),
                    ),
                  );
                },
                child: const Text('Browser'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PermissionPage(),
                    ),
                  );
                },
                child: const Text('Permission'),
              ),
            ],
          ),
        ),
      );
}
