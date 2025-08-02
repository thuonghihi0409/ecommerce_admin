import 'package:flutter/material.dart';

class OverlayLoadingCustom extends StatelessWidget {
  final Widget child;
  final Widget loadingWidget;
  const OverlayLoadingCustom(
      {super.key, required this.child, required this.loadingWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        loadingWidget,
      ],
    );
  }
}
