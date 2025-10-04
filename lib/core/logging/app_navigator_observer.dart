import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_logger.dart';

class AppNavigatorObserver extends AutoRouterObserver {
  AppNavigatorObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final newRouteName = route.settings.name;
    final previousRouteName = previousRoute?.settings.name;

    logInfo('PUSH $previousRouteName -> $newRouteName');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final poppedRouteName = route.settings.name;
    final returnedRouteName = previousRoute?.settings.name;

    logInfo('POP $poppedRouteName -> $returnedRouteName');
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final newRouteName = newRoute?.settings.name;
    final replacedRouteName = oldRoute?.settings.name;

    logInfo('REPLACE  $replacedRouteName -> $newRouteName');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final removedRouteName = route.settings.name;

    logInfo('Route removed $removedRouteName');
    super.didRemove(route, previousRoute);
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    logInfo('TAB visited ${previousRoute?.name} -> ${route.name}\n');
    super.didInitTabRoute(route, previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    logInfo('TAB RE-VISITED ${previousRoute.name} -> ${route.name}\n');
    super.didChangeTabRoute(route, previousRoute);
  }
}
