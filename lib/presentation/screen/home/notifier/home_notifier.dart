import 'package:flutter/foundation.dart';

import 'package:clueminati_app/services/firebase_service.dart';
import 'package:clueminati_app/presentation/screen/home/data/home_screen_data.dart';

class HomeNotifier with ChangeNotifier {
  final FirebaseAppNotifier _firebaseAppNotifier;

  bool _listenChanges = true;
  bool _signout = false;
  HomeScreenState _currentState = HomeScreenState.loading;

  HomeNotifier(this._firebaseAppNotifier) {
    _currentState = HomeScreenState.loading;
  }
  HomeScreenState get currentState => _currentState;

  bool get listenChanges => _listenChanges;
  bool get signout => _signout;

  HomeScreenState getCurrentWidgetState() {
    if (_firebaseAppNotifier.initialized) {
      _listenChanges = false;
      return HomeScreenState.primary;
    } else {
      return HomeScreenState.loading;
    }
  }

  void signoutUser() {
    _signout = true;
    _currentState = HomeScreenState.exit;
    _firebaseAppNotifier.signOut();
    notifyListeners();
  }
}
