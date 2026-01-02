import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router.dart';

extension DialogRouter on StackRouter {
  Future<T?> showAppDialog<T>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
  }) async {
    final result = await push(
      AppDialogRoute(barrierDismissible: barrierDismissible, builder: builder),
    );
    if (result is T) {
      return result;
    }
    return null;
  }
}
