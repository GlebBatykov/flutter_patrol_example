import 'package:flutter/material.dart';

import '../keys.dart';

class PressBackPage extends StatefulWidget {
  const PressBackPage({super.key});

  @override
  State<StatefulWidget> createState() => _PressBackPageState();
}

class _PressBackPageState extends State<PressBackPage> {
  bool _didPop = false;

  void _onPopInvoked(bool didPop) {
    if (!didPop) {
      showDialog(
        context: context,
        builder: (_) => _CloseDialog(
          closePageCallback: _closePageCallback,
        ),
      );
    }
  }

  void _closePageCallback() {
    setState(() {
      _didPop = true;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Press back'),
          leading: const BackButton(
            key: Keys.backButton,
          ),
        ),
        body: PopScope(
          canPop: _didPop,
          onPopInvoked: _onPopInvoked,
          child: const SizedBox.shrink(),
        ),
      );
}

class _CloseDialog extends StatelessWidget {
  final VoidCallback closePageCallback;

  const _CloseDialog({
    required this.closePageCallback,
  });

  @override
  Widget build(BuildContext context) => Dialog(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Close the page?',
                  style: TextStyle(fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();

                        closePageCallback();
                      },
                      child: const Text('Close page'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}
