import 'package:flutter/material.dart';

import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NoNetwork extends StatelessWidget {
  const NoNetwork({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(.95),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.signal_wifi_off, size: 50, color: Colors.red),
                const SizedBox(height: 20),
                const AutoSizeText(
                  'No Internet Connection',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                AutoSizeText(
                  'Please check your connection and try again.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextButton(
                  child: const Text('FINE'),
                  onPressed: () {
                    FlutterExitApp.exitApp(iosForceExit: true);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
