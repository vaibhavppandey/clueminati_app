import 'package:auto_size_text/auto_size_text.dart';
import 'package:clueminati_app/presentation/components/frosted_glass_container.dart';
import 'package:clueminati_app/theme/colours.dart';
import 'package:flutter/material.dart';

class FrostedTeamRankPosContainer extends StatefulWidget {
  const FrostedTeamRankPosContainer({
    super.key,
    required this.rank,
    required this.teamName,
    required this.score,
    this.currentPlayer = false,
  });

  final int rank;
  final String teamName;
  final int score;
  final bool currentPlayer;

  @override
  State<FrostedTeamRankPosContainer> createState() =>
      _FrostedTeamRankPosContainerState();
}

class _FrostedTeamRankPosContainerState
    extends State<FrostedTeamRankPosContainer> {
  @override
  Widget build(BuildContext context) {
    return FrostedGlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        height: 60,
        radius: 24,
        // width: 300,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 40,
                  child: AutoSizeText(widget.rank.toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          foreground: _getRankPaintStyle(kClueMinatiGreen500))),
                ),
                const SizedBox(width: 8.0),
                AutoSizeText(widget.teamName,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: kClueMinatiWhite)),
              ],
            ),
            AutoSizeText(widget.score.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: kClueMinatiGreen500)),
          ],
        ));
  }

  Paint _getRankPaintStyle(Color primary) {
    final paintStyle = Paint();
    if (widget.currentPlayer) {
      paintStyle
        ..color = primary
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 4.0);
    } else {
      paintStyle
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = primary;
    }

    return paintStyle;
  }
}
