import 'package:flutter/material.dart';

import 'package:clueminati_app/theme/colours.dart';

const _fontFamily = "Adieu";

ThemeData get buildClueMinatiTheme {
  final ThemeData base = ThemeData(
      useMaterial3: true,
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.fromSeed(
          seedColor: kClueMinatiGreen500, brightness: Brightness.dark));
  final clueMinatiTextTheme = _buildClueMinatiTextTheme(base.textTheme);
  return base.copyWith(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        minimumSize: const Size(0, 64),
        backgroundColor: kClueMinatiGreen500,
        foregroundColor: kClueMinatiWhite,
        textStyle: clueMinatiTextTheme.titleLarge,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          elevation: 8,
          foregroundColor: kClueMinatiGreen500,
          textStyle: clueMinatiTextTheme.bodyLarge,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)))),
    ),
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: clueMinatiTextTheme.bodyMedium
            ?.copyWith(fontWeight: FontWeight.w300),
        hintStyle: clueMinatiTextTheme.bodyMedium
            ?.copyWith(color: kClueMinatiGrey, fontWeight: FontWeight.w300),
        contentPadding: const EdgeInsets.all(12),
        alignLabelWithHint: true,
        outlineBorder: BorderSide.none,
        border: const UnderlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none)),
    dialogTheme: DialogTheme(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: clueMinatiTextTheme.titleLarge,
        contentTextStyle: clueMinatiTextTheme.bodySmall,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)))),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.black.withOpacity(.95),
        contentTextStyle: clueMinatiTextTheme.bodyLarge,
        elevation: 8.0,
        behavior: SnackBarBehavior.floating),
  );
}

TextTheme _buildClueMinatiTextTheme(TextTheme base) {
  return base
      .copyWith(
        displaySmall: base.displaySmall!.copyWith(
          fontSize: 36,
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: base.headlineLarge!.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: base.headlineMedium!.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: base.headlineSmall!.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: base.bodyMedium!.copyWith(
          fontSize: 22.0,
          fontWeight: FontWeight.w400,
        ),
        titleSmall: base.titleSmall!.copyWith(
          color: kClueMinatiGreen500,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        bodyLarge: base.bodyLarge!.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: base.bodySmall!.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
      )
      .apply(
        fontFamily: _fontFamily,
        displayColor: kClueMinatiWhite,
        bodyColor: kClueMinatiWhite,
      );
}
