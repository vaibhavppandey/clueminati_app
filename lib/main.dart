import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_service.dart';
import 'firebase_options.dart';

import 'package:clueminati_app/app.dart';
import 'package:clueminati_app/services/net_connectivity_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // don't rotate
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // start splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // init firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NetConnectivityService()),
    ChangeNotifierProvider(create: (_) => FirebaseAppNotifier()),
  ], builder: (_, __) => const ClueminatiApp()));
}
