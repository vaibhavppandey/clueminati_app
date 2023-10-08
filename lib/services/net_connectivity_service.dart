import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetConnectivityService extends ChangeNotifier {
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  final Connectivity _connectivity = Connectivity();

  NetConnectivityService() {
    _connectivity.checkConnectivity().then(_updateConnectionStatus);
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        _isConnected = true;
        break;
      case ConnectivityResult.none:
        _isConnected = false;
        break;
      default:
        _isConnected = false;
        break;
    }
    notifyListeners();
  }
}
