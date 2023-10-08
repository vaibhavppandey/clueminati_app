import 'package:flutter/material.dart';

import 'package:clueminati_app/presentation/screen/no_network_screen.dart';
import 'package:clueminati_app/presentation/screen/home/screen.dart';
import 'package:clueminati_app/presentation/screen/root.dart';
import 'package:clueminati_app/presentation/screen/leaderboard/screen.dart';
import 'package:clueminati_app/presentation/screen/scan_question.dart';
import 'package:clueminati_app/presentation/screen/login.dart';
import 'package:clueminati_app/presentation/screen/welcome.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const RootScreen());
    case '/welcome':
      return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    case '/login':
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case '/question':
      return MaterialPageRoute(builder: (_) => const ScanQuestionScreen());
    case '/home':
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case '/leaderboard':
      return MaterialPageRoute(builder: (_) => const Leaderboard());
    case '/nonetwork':
      return MaterialPageRoute(builder: (_) => const NoNetwork());
    default:
      throw Exception('Undefined route ${settings.name}');
  }
}
