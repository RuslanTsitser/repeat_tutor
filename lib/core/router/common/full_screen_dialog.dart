import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../router.dart';

extension FullScreenDialogRouter on StackRouter {
  Future<T?> showAppFullScreenDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) async {
    final result = await push(AppFullRoute(builder: builder));
    if (result is T) {
      return result;
    }
    return null;
  }

  Future<T?> routeWrapper<T>({
    required WidgetBuilder builder,
  }) async {
    final result = await push(AppRouteWrapperRoute(builder: builder));
    if (result is T) {
      return result;
    }
    return null;
  }
}
