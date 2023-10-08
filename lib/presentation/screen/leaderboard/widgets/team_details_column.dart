import 'package:auto_size_text/auto_size_text.dart';
import 'package:clueminati_app/theme/colours.dart';
import 'package:flutter/material.dart';

class TeamDetailsColumn extends StatefulWidget {
  const TeamDetailsColumn(
      {super.key, required this.dataType, required this.data});

  final String dataType;
  final int data;

  @override
  State<TeamDetailsColumn> createState() => TeamDetailsColumnState();
}

class TeamDetailsColumnState extends State<TeamDetailsColumn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AutoSizeText(
          widget.dataType,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: kClueMinatiGreen500),
        ),
        AutoSizeText(
          widget.data.toString(),
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: kClueMinatiWhite),
        ),
      ],
    );
  }
}
