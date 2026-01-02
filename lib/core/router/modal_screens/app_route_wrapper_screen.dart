import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

@RoutePage()
class AppRouteWrapperScreen extends StatelessWidget
    implements AutoRouteWrapper {
  const AppRouteWrapperScreen({super.key, required this.builder});
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }
}
