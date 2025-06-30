import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../keys.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _isGranted = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final granted = await Permission.notification.isGranted;

    setState(() {
      _isGranted = granted;
    });
  }

  Future<void> _showNotification() async {
    if (!_isInitialized) {
      final result = await _plugin.initialize(
        const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        ),
      );

      if (result == true) {
        _isInitialized = true;
      } else {
        return;
      }
    }

    await _plugin.show(
      Random().nextInt(100000),
      'Hello, from notification!',
      'You can see me!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test notification channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          threadIdentifier: 'test_thread',
        ),
      ),
    );
  }

  Future<void> _requestPermission() async {
    final status = await Permission.notification.request();

    setState(() {
      _isGranted = status.isGranted;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
          leading: const BackButton(
            key: Keys.backButton,
          ),
        ),
        body: Center(
          child: _isGranted
              ? ElevatedButton(
                  onPressed: _showNotification,
                  child: const Text('Show notification'),
                )
              : ElevatedButton(
                  onPressed: _requestPermission,
                  child: const Text('Get permission'),
                ),
        ),
      );
}
