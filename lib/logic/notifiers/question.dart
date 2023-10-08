import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' show Barcode;

class QuestionNotifier extends ChangeNotifier {
  String _question = 'Waiting Data';
  bool _isScanned = false;
  bool _scanShownQr = false;

  String get question => _question;
  bool get isScanned => _isScanned;
  bool get scanShownQr => _scanShownQr;

  void setScannedQuestion(Barcode? scanData) {
    _question =
        scanData != null ? scanData.code ?? 'WaitingData' : "Start Scanning";
    _isScanned = true;
    notifyListeners();
  }

  void startScanningShownQr() {
    _scanShownQr = true;
    notifyListeners();
  }

  void stopScanningShownQr() {
    _scanShownQr = false;
    notifyListeners();
  }

  void reset() {
    _question = '';
    _isScanned = false;
    notifyListeners();
  }
}
