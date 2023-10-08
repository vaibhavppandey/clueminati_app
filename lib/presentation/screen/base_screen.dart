import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:clueminati_app/services/net_connectivity_service.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({
    super.key,
    this.sprite,
    this.imageAssets,
    this.spriteAlignment,
    this.padding,
    required this.child,
  });
  final String? sprite;
  final List<String>? imageAssets;
  final Alignment? spriteAlignment;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late AssetImage backgroundImage;
  late Image? spriteImage;
  bool willPop = true;

  @override
  void initState() {
    super.initState();
    backgroundImage = const AssetImage("assets/png/bg.png");
    if (widget.sprite != null) {
      spriteImage = Image.asset(widget.sprite!);
    } else {
      spriteImage = null;
    }
  }

  @override
  void didChangeDependencies() {
    precacheImage(backgroundImage, context);
    if (spriteImage != null) {
      precacheImage(spriteImage!.image, context);
    }
    if (widget.imageAssets != null) {
      widget.imageAssets?.forEach(
          (String asset) => precacheImage(AssetImage(asset), context));
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<NetConnectivityService>(context)
        .addListener(_netStateChangeAction);
    return WillPopScope(
      onWillPop: () async => willPop,
      child: Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: backgroundImage,
              fit: BoxFit.cover,
            )),
            child: Stack(
              fit: StackFit.expand,
              // alignment: Alignment.center,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: <Widget>[
                if (widget.sprite != null && widget.spriteAlignment != null)
                  Align(
                      alignment: widget.spriteAlignment!, child: spriteImage!),
                Padding(
                  padding: widget.padding ?? EdgeInsets.zero,
                  child: widget.child,
                ),
              ],
            )),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  void _netStateChangeAction() {
    if (!context.read<NetConnectivityService>().isConnected) {
      Navigator.pushNamed(context, '/nonetwork');
    } else if (Navigator.canPop(context) &&
        _isCurrentRouteNamed('/nonetwork', context)) {
      Navigator.pop(context);
    }
  }

  bool _isCurrentRouteNamed(String name, BuildContext context) {
    bool isCurrent = false;

    Navigator.popUntil(context, (route) {
      if (route.settings.name == name) {
        isCurrent = true;
      }
      return true;
    });

    return isCurrent;
  }
}
