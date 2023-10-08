import 'dart:io';

import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clueminati_app/theme/colours.dart';

import 'package:clueminati_app/presentation/screen/base_screen.dart';
import 'package:clueminati_app/constants/assets.dart' as assets;

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanQuestionScreen extends StatefulWidget {
  const ScanQuestionScreen({super.key});

  @override
  State<ScanQuestionScreen> createState() => _ScanQuestionScreenState();
}

class _ScanQuestionScreenState extends State<ScanQuestionScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? questionBarcode;
  bool scanShownQr = false;

  // work qr on dev mode
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      sprite: assets.fone,
      spriteAlignment: Alignment.topRight,
      padding:
          const EdgeInsets.only(left: 36.0, right: 36.0, top: 48, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: <Widget>[
              AutoSizeText("Scan your",
                  style: Theme.of(context).textTheme.headlineLarge),
              AutoSizeText("QR code",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: kClueMinatiGreen500)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
              height: 325,
              width: 300,
              child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: <Widget>[
                    Center(
                        child: SizedBox(
                      height: 275,
                      width: 250,
                      child:
                          QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
                    )),
                    ...qrSurroundingBorders()
                  ])),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed:
                !scanShownQr ? () => setState(() => scanShownQr = true) : null,
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36, vertical: 8)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.qr_code_scanner_rounded,
                    size: 32, color: kClueMinatiWhite),
                const SizedBox(width: 8),
                AutoSizeText(scanShownQr ? "Scanning.." : "Scan NOW",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: kClueMinatiWhite)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((Barcode scanData) {
      setState(() {
        if (scanShownQr) {
          questionBarcode = scanData;
          scanShownQr = false;
          _showQuestionDialog();
        }
      });
      // Navigator.pushNamed(context, "/home");
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _showQuestionDialog() async {
    return showDialog<void>(
      barrierColor: Colors.black.withOpacity(.95),
      useSafeArea: false,
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        Future.delayed(
            const Duration(seconds: 25), () => Navigator.of(context).pop());
        return Dialog.fullscreen(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () async {
                      Uri questionUri = Uri.parse(questionBarcode!.code!);
                      if (!await launchUrl(questionUri)) {
                        Future.microtask(() => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: SnackBar(
                                    content: Text("Question didn't open")))));
                      } else {
                        Future.delayed(const Duration(seconds: 2),
                            () => Navigator.pop(context));
                      }
                    },
                    child: Text(
                      "GET QUESTION NOW!",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: kClueMinatiGreen500),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Align> qrSurroundingBorders() {
    Map<String, Alignment> borderPosMap = {
      "topLeft": Alignment.topLeft,
      "topRight": Alignment.topRight,
      "bottomRight": Alignment.bottomRight,
      "bottomLeft": Alignment.bottomLeft,
    };

    return borderPosMap.entries
        .map((MapEntry<String, Alignment> entry) => Align(
            alignment: entry.value,
            child: Image.asset("${assets.base}/border/${entry.key}.png")))
        .toList();
  }
}
