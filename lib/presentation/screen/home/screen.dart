import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

import 'package:clueminati_app/constants/assets.dart' as assets;
import 'package:clueminati_app/services/firebase_service.dart';

import 'package:clueminati_app/presentation/screen/base_screen.dart';
import 'package:clueminati_app/presentation/screen/home/widgets/primary.dart';
import 'package:clueminati_app/presentation/screen/home/widgets/exit.dart';
import 'package:clueminati_app/presentation/screen/home/widgets/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget currentWidget = const SizedBox.shrink();
  bool listenChanges = true;
  bool signout = false;

  @override
  Widget build(BuildContext context) {
    if (listenChanges) {
      currentWidget = getCurrentWidget();
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BaseScreen(
        spriteAlignment: Alignment.bottomRight,
        sprite: assets.magnify,
        imageAssets: const <String>[assets.qr, assets.graph],
        padding: const EdgeInsets.only(
            left: 36.0, right: 36.0, top: 48.0, bottom: 12.0),
        child: currentWidget,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    bool willPop = false;
    if (!signout) {
      await showDialog(
        useSafeArea: false,
        barrierColor: Colors.black.withOpacity(.95),
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('WANNA LEAVE?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("You are about to exit the app"),
                Text("but you might wanna signout too?"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('EXIT'),
              onPressed: () async {
                FlutterExitApp.exitApp(iosForceExit: true);
              },
            ),
            TextButton(
              child: const AutoSizeText('SIGNOUT'),
              onPressed: () async {
                Navigator.of(context).pop(); // This line pops the dialog
                Provider.of<FirebaseAppNotifier>(context, listen: false)
                    .deInitialize();
                setState(() {
                  signout = true;
                  currentWidget = const HomeExitWidget();
                });
                Provider.of<FirebaseAppNotifier>(context, listen: false)
                    .signOut();
                await Future.delayed(const Duration(seconds: 2));
                FlutterExitApp.exitApp(iosForceExit: true);
              },
            ),
          ],
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
    }
    return willPop;
  }

  Widget getCurrentWidget() {
    if (Provider.of<FirebaseAppNotifier>(context).initialized) {
      setState(() {
        listenChanges = false;
      });
      return const HomePrimaryWidget();
    } else {
      return const HomeLoadingWidget();
    }
  }
}



// class HomeAlertDialog extends StatelessWidget {
//   const HomeAlertDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//         title: const Text('WANNA LEAVE?'),
//         content: const SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text("You are about to exit the app"),
//               Text("but you might wanna signout too?"),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('EXIT'),
//             onPressed: () async {
//               FlutterExitApp.exitApp(iosForceExit: true);
//             },
//           ),
//           TextButton(
//             child: const Text('SIGNOUT'),
//             onPressed: () async {
//               willPop = false;
//               Provider.of<FirebaseAppNotifier>(context, listen: false)
//                   .deInitialize();
//               setState(() {
//                 currentWidget = Center(
//                   child: FittedBox(
//                     fit: BoxFit.fitWidth,
//                     child: Text(
//                       "GOODBYE",
//                       style: Theme.of(context).textTheme.displayLarge,
//                     ),
//                   ),
//                 );
//                 Provider.of<FirebaseAppNotifier>(context, listen: false)
//                     .signOut();
//               });
//               Future.microtask(() {
//                 setState(() => willPop = false);
//                 Navigator.pushNamed(context, '/welcome');
//               });
//             },
//           ),
//         ],
//       );
//   }
// }