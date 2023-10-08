import 'package:auto_size_text/auto_size_text.dart';
import 'package:clueminati_app/presentation/components/frosted_glass_container.dart';
import 'package:clueminati_app/presentation/screen/leaderboard/widgets/team_details_column.dart';
import 'package:clueminati_app/services/firebase_service.dart';
import 'package:clueminati_app/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrostedCurrentTeamLeaderboardCard extends StatefulWidget {
  const FrostedCurrentTeamLeaderboardCard({super.key});

  @override
  State<FrostedCurrentTeamLeaderboardCard> createState() =>
      _FrostedCurrentTeamLeaderboardCardState();
}

class _FrostedCurrentTeamLeaderboardCardState
    extends State<FrostedCurrentTeamLeaderboardCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseAppNotifier>(builder: (context, notifier, _) {
      return FrostedGlassContainer(
          // width: 300,
          height: 150,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.people_rounded,
                      size: 48, color: kClueMinatiWhite),
                  const SizedBox(width: 4),
                  AutoSizeText(notifier.team.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: kClueMinatiWhite)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TeamDetailsColumn(dataType: "Rank", data: notifier.rank),
                  TeamDetailsColumn(
                      dataType: "Score", data: notifier.team.score),
                ],
              ),
            ],
            // List of teams
          ));
    });
  }
}
