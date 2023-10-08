import 'package:clueminati_app/presentation/screen/leaderboard/widgets/team_leaderboard_listview.dart';
import 'package:flutter/material.dart';

import 'package:clueminati_app/presentation/screen/leaderboard/widgets/frosted_current_team_card.dart';
import 'package:clueminati_app/presentation/screen/leaderboard/widgets/leaderboard_indicator_text.dart';
import 'package:clueminati_app/presentation/screen/base_screen.dart';
import 'package:clueminati_app/constants/assets.dart' as assets;

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      sprite: assets.shocked,
      spriteAlignment: Alignment.topRight,
      child: Padding(
        padding:
            EdgeInsets.only(left: 24.0, right: 24.0, top: 36.0, bottom: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Spacer(flex: 3),
            FrostedCurrentTeamLeaderboardCard(),
            Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 8),
              child: LeaderboardIndicatorText(),
            ),
            Expanded(
              flex: 17,
              child: LeaderboardTeamsPosListView(),
            ),
          ],
        ),
      ),
    );
  }
}
