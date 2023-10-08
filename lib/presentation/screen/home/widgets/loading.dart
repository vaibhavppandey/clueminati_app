import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FittedBox(
          fit: BoxFit.fitWidth,
          child: AutoSizeText(
            "Getting you ready",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.all(4.0),
          child: SizedBox(
              width: double.infinity,
              height: 4,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              )),
        )
      ],
    ));
  }
}
