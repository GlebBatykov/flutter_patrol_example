import 'package:flutter/material.dart';

import 'pages/route_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: RoutePage(),
      );
}
