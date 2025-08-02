import 'package:flutter/material.dart';

class FadePageRoute<T> extends PageRoute<T> {
  final Widget child;
  final Duration duration;
  final Color color;

  FadePageRoute({
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.color = Colors.white,
  });

  @override
  Color get barrierColor => color;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class NavigationService {
  static final NavigationService instance = NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigationService._internal();

  Future<T?> push<T>(Widget page, {BuildContext? context}) {
    final route = MaterialPageRoute<T>(builder: (_) => page);
    if (context != null) {
      return Navigator.push<T>(context, route);
    }
    return navigatorKey.currentState!.push(route);
  }

  Future<T?> pushFade<T>(Widget page, {BuildContext? context}) {
    final route = FadePageRoute<T>(child: page);
    if (context != null) {
      return Navigator.push(context, route);
    }
    return navigatorKey.currentState!.push(route);
  }

  /// Replace current route
  Future<T?> replace<T>(Widget page,
      {BuildContext? context, bool isFadeRoute = false}) {
    final route = isFadeRoute
        ? FadePageRoute<T>(child: page)
        : MaterialPageRoute<T>(builder: (_) => page);
    if (context != null) {
      return Navigator.pushReplacement(context, route);
    }
    return navigatorKey.currentState!.pushReplacement(route);
  }

  /// Pop all and replace to root
  Future<T?> popUntilRootAndReplace<T>(Widget page, {BuildContext? context}) {
    if (context != null) {
      Navigator.popUntil(context, (route) => route.isFirst);
      return replace(page, context: context);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    return replace(page);
  }

  /// Navigate to replacement in tab
  Future<T?> navigateToReplacementInTab<T>({
    required BuildContext context,
    bool isHoldTab = true,
    required Widget screen,
    PageRoute<T>? pageRoute,
  }) {
    return Navigator.of(context, rootNavigator: !isHoldTab).pushReplacement(
      pageRoute ?? MaterialPageRoute(builder: (_) => screen),
    );
  }

  /// Navigate to in tab
  Future<T?> navigateToInTab<T>({
    required BuildContext context,
    bool isHoldTab = true,
    required Widget screen,
    PageRoute<T>? pageRoute,
  }) {
    return Navigator.of(context, rootNavigator: !isHoldTab).push(
      pageRoute ?? MaterialPageRoute(builder: (_) => screen),
    );
  }

  /// Go back (pop)
  void goBack<T>({BuildContext? context, T? result}) {
    if (context != null) {
      Navigator.pop(context, result);
    } else {
      navigatorKey.currentState?.pop(result);
    }
  }

  /// Pop until first route
  void popToRoot({BuildContext? context}) {
    if (context != null) {
      Navigator.popUntil(context, (route) => route.isFirst);
    } else {
      navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
  }

  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  Future<dynamic> pushNamed(String name, {dynamic arguments}) {
    return routeObserver.navigator!.pushNamed(name, arguments: arguments);
  }

  Future<dynamic> replaceNamed(String name, {dynamic arguments}) {
    return routeObserver.navigator!.popAndPushNamed(name, arguments: arguments);
  }
}
