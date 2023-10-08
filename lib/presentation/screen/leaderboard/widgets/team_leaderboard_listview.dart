import 'package:clueminati_app/data/models/team.dart';
import 'package:clueminati_app/presentation/screen/leaderboard/widgets/frosted_team_rank_view.dart';
import 'package:clueminati_app/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeaderboardTeamsPosListView extends StatefulWidget {
  const LeaderboardTeamsPosListView({super.key});

  @override
  State<LeaderboardTeamsPosListView> createState() =>
      _LeaderboardTeamsPosListViewState();
}

class _LeaderboardTeamsPosListViewState
    extends State<LeaderboardTeamsPosListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseAppNotifier>(builder: (context, notifier, _) {
      return ListView.separated(
        clipBehavior: Clip.antiAlias,
        padding: const EdgeInsets.only(bottom: 4.0 /*36.0*/),
        itemCount: notifier.teams.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16.0),
        itemBuilder: (context, index) {
          Team team = notifier.teams[index];
          return FrostedTeamRankPosContainer(
            rank: index + 1,
            teamName: team.name,
            score: team.score,
            currentPlayer: notifier.team.uid == team.uid,
          );
        },
      );
    });
  }
}
