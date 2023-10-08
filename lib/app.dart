import 'package:flutter/material.dart';

import 'package:clueminati_app/theme/gobal_theme.dart';
import 'package:clueminati_app/presentation/router/on_generate_route.dart';

class ClueminatiApp extends StatelessWidget {
  const ClueminatiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData clueMinatiTheme = buildClueMinatiTheme;
    return MaterialApp(
      key: key,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: clueMinatiTheme,
      darkTheme: clueMinatiTheme,
      initialRoute: '/',
      onGenerateRoute: generateRoute,
    );
  }
}
