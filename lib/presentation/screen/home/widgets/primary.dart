import 'package:clueminati_app/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:clueminati_app/services/firebase_service.dart';
import 'package:clueminati_app/constants/assets.dart' as assets;
import 'package:clueminati_app/presentation/screen/home/widgets/frosted_home_action_container.dart';

class HomePrimaryWidget extends StatelessWidget {
  const HomePrimaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(.5, -.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.people, color: kClueMinatiWhite, size: 108),
                const SizedBox(width: 16),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Team",
                        style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(height: 4.0),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        Provider.of<FirebaseAppNotifier>(context).team.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          //leaderboard, qr code
          FrostedHomeActionContainer(
              topic: "Leaderboard",
              description: "Find your rank!",
              icon: assets.graph,
              onPressed: () => Navigator.pushNamed(context, '/leaderboard')),
          const SizedBox(height: 20),
          FrostedHomeActionContainer(
              topic: "Scan QR",
              description: "Scan qr code to submit your answer",
              icon: assets.qr,
              onPressed: () => Navigator.pushNamed(context, '/question')),
        ],
      ),
    );
  }
}
