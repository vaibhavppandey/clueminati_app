import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HomeExitWidget extends StatelessWidget {
  const HomeExitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: AutoSizeText(
          "GOODBYE",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}
