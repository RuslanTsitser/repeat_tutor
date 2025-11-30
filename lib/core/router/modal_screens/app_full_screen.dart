import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class AppFullScreen extends StatelessWidget {
  const AppFullScreen({
    super.key,
    required this.builder,
  });
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
