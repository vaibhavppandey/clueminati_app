import 'package:flutter/material.dart';

import 'package:clueminati_app/theme/colours.dart';
import 'package:clueminati_app/presentation/components/frosted_glass_container.dart';

class FrostedTextField extends StatelessWidget {
  final String label;
  final bool? isPassword;
  final TextEditingController controller;
  const FrostedTextField({
    super.key,
    required this.label,
    this.isPassword,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(24)),
      child: FrostedGlassContainer(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: TextField(
              controller: controller,
              obscureText: isPassword ?? false,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w300, color: kClueMinatiWhite),
              decoration: InputDecoration(
                hintText: label,
              ),
            ),
          )),
    );
  }
}
