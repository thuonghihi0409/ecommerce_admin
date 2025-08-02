import 'package:flutter/widgets.dart';

class AppLifecycleHandler extends WidgetsBindingObserver {
  final Future<void> Function()? onResumed;

  AppLifecycleHandler({this.onResumed});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResumed?.call();
    }
  }
}
