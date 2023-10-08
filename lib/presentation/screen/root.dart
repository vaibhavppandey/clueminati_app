import 'package:flutter/material.dart';
import 'package:clueminati_app/services/firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<FirebaseAppNotifier>(context, listen: true);

    if (!notifier.initialized) {
      return const SizedBox.shrink();
    }

    if (notifier.loggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FlutterNativeSplash.remove(); // Remove the splash screen
        Navigator.of(context).pushReplacementNamed('/home');
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FlutterNativeSplash.remove(); // Remove the splash screen
        Navigator.of(context).pushReplacementNamed('/welcome');
      });
    }

    return const SizedBox.shrink();
  }
}
