import 'package:auto_size_text/auto_size_text.dart';
import 'package:clueminati_app/theme/colours.dart';
import 'package:flutter/material.dart';
import 'package:clueminati_app/presentation/components/frosted_glass_container.dart';

class FrostedHomeActionContainer extends StatelessWidget {
  final String topic;
  final String description;
  final String icon;
  final VoidCallback onPressed;
  const FrostedHomeActionContainer({
    super.key,
    required this.topic,
    required this.description,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: FrostedGlassContainer(
        height: 100,
        width: 325,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, right: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 75,
                decoration: BoxDecoration(
                    color: kClueMinatiWhite.withOpacity(.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(50),
                      bottomLeft: Radius.circular(27),
                      bottomRight: Radius.circular(50),
                    )),
                child: Center(child: Image.asset(icon)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(topic,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: kClueMinatiGreen500)),
                    const SizedBox(height: 8),
                    AutoSizeText(description,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
