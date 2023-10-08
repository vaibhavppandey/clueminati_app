import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:clueminati_app/constants/assets.dart' as assets;

import 'package:clueminati_app/presentation/screen/base_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      // sprite: assets.happy, spriteAlignment: Alignment.center,
      imageAssets: const <String>[assets.brand, assets.happy],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(assets.brand),
          const SizedBox(height: 48),
          Image.asset(assets.happy),
          const SizedBox(height: 72),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const AutoSizeText("GET STARTED"),
          ),
        ],
      ),
    );
  }
}
