import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../keys.dart';

class BrowserPage extends StatelessWidget {
  const BrowserPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Browser'),
          leading: const BackButton(
            key: Keys.backButton,
          ),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              launchUrl(Uri.parse('https://ya.ru'));
            },
            child: const Text('Open browser'),
          ),
        ),
      );
}
