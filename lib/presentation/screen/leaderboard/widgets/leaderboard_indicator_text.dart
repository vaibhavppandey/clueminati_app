import 'package:auto_size_text/auto_size_text.dart';
import 'package:clueminati_app/theme/colours.dart';
import 'package:flutter/material.dart';

class LeaderboardIndicatorText extends StatefulWidget {
  const LeaderboardIndicatorText({super.key});

  @override
  State<LeaderboardIndicatorText> createState() =>
      _LeaderboardIndicatorTextState();
}

class _LeaderboardIndicatorTextState extends State<LeaderboardIndicatorText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.menu, size: 48, color: kClueMinatiWhite),
        const SizedBox(width: 4.0),
        AutoSizeText(
          "Leaderboard",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
