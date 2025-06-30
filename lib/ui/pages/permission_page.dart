import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

import '../keys.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<StatefulWidget> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  bool _isGranted = false;

  @override
  void initState() {
    super.initState();

    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final granded = await Permission.camera.isGranted;

    setState(() {
      _isGranted = granded;
    });
  }

  Future<void> _requestPermission() async {
    final status = await Permission.camera.request();

    setState(() {
      _isGranted = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Permission'),
          leading: const BackButton(
            key: Keys.backButton,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isGranted ? 'Have permission' : 'Don\'t have permission',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 15,
              ),
              if (!_isGranted)
                ElevatedButton(
                  onPressed: _requestPermission,
                  child: const Text('Get permission'),
                ),
            ],
          ),
        ),
      );
}
