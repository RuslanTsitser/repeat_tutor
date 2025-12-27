// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AppDialogScreen]
class AppDialogRoute extends PageRouteInfo<AppDialogRouteArgs> {
  AppDialogRoute({
    Key? key,
    required WidgetBuilder builder,
    required bool barrierDismissible,
    List<PageRouteInfo>? children,
  }) : super(
         AppDialogRoute.name,
         args: AppDialogRouteArgs(
           key: key,
           builder: builder,
           barrierDismissible: barrierDismissible,
         ),
         initialChildren: children,
       );

  static const String name = 'AppDialogRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppDialogRouteArgs>();
      return AppDialogScreen(
        key: args.key,
        builder: args.builder,
        barrierDismissible: args.barrierDismissible,
      );
    },
  );
}

class AppDialogRouteArgs {
  const AppDialogRouteArgs({
    this.key,
    required this.builder,
    required this.barrierDismissible,
  });

  final Key? key;

  final WidgetBuilder builder;

  final bool barrierDismissible;

  @override
  String toString() {
    return 'AppDialogRouteArgs{key: $key, builder: $builder, barrierDismissible: $barrierDismissible}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppDialogRouteArgs) return false;
    return key == other.key &&
        builder == other.builder &&
        barrierDismissible == other.barrierDismissible;
  }

  @override
  int get hashCode =>
      key.hashCode ^ builder.hashCode ^ barrierDismissible.hashCode;
}

/// generated route for
/// [AppFullScreen]
class AppFullRoute extends PageRouteInfo<AppFullRouteArgs> {
  AppFullRoute({
    Key? key,
    required WidgetBuilder builder,
    List<PageRouteInfo>? children,
  }) : super(
         AppFullRoute.name,
         args: AppFullRouteArgs(key: key, builder: builder),
         initialChildren: children,
       );

  static const String name = 'AppFullRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppFullRouteArgs>();
      return AppFullScreen(key: args.key, builder: args.builder);
    },
  );
}

class AppFullRouteArgs {
  const AppFullRouteArgs({this.key, required this.builder});

  final Key? key;

  final WidgetBuilder builder;

  @override
  String toString() {
    return 'AppFullRouteArgs{key: $key, builder: $builder}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppFullRouteArgs) return false;
    return key == other.key && builder == other.builder;
  }

  @override
  int get hashCode => key.hashCode ^ builder.hashCode;
}

/// generated route for
/// [AppModalBottomSheetScreen]
class AppModalBottomSheetRoute
    extends PageRouteInfo<AppModalBottomSheetRouteArgs> {
  AppModalBottomSheetRoute({
    Key? key,
    required WidgetBuilder builder,
    Color? backgroundColor,
    String? barrierLabel,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
    required bool isScrollControlled,
    required double scrollControlDisabledMaxHeightRatio,
    required bool useRootNavigator,
    required bool isDismissible,
    required bool enableDrag,
    bool? showDragHandle,
    required bool useSafeArea,
    RouteSettings? routeSettings,
    AnimationController? transitionAnimationController,
    Offset? anchorPoint,
    AnimationStyle? sheetAnimationStyle,
    List<PageRouteInfo>? children,
  }) : super(
         AppModalBottomSheetRoute.name,
         args: AppModalBottomSheetRouteArgs(
           key: key,
           builder: builder,
           backgroundColor: backgroundColor,
           barrierLabel: barrierLabel,
           elevation: elevation,
           shape: shape,
           clipBehavior: clipBehavior,
           constraints: constraints,
           barrierColor: barrierColor,
           isScrollControlled: isScrollControlled,
           scrollControlDisabledMaxHeightRatio:
               scrollControlDisabledMaxHeightRatio,
           useRootNavigator: useRootNavigator,
           isDismissible: isDismissible,
           enableDrag: enableDrag,
           showDragHandle: showDragHandle,
           useSafeArea: useSafeArea,
           routeSettings: routeSettings,
           transitionAnimationController: transitionAnimationController,
           anchorPoint: anchorPoint,
           sheetAnimationStyle: sheetAnimationStyle,
         ),
         initialChildren: children,
       );

  static const String name = 'AppModalBottomSheetRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppModalBottomSheetRouteArgs>();
      return AppModalBottomSheetScreen(
        key: args.key,
        builder: args.builder,
        backgroundColor: args.backgroundColor,
        barrierLabel: args.barrierLabel,
        elevation: args.elevation,
        shape: args.shape,
        clipBehavior: args.clipBehavior,
        constraints: args.constraints,
        barrierColor: args.barrierColor,
        isScrollControlled: args.isScrollControlled,
        scrollControlDisabledMaxHeightRatio:
            args.scrollControlDisabledMaxHeightRatio,
        useRootNavigator: args.useRootNavigator,
        isDismissible: args.isDismissible,
        enableDrag: args.enableDrag,
        showDragHandle: args.showDragHandle,
        useSafeArea: args.useSafeArea,
        routeSettings: args.routeSettings,
        transitionAnimationController: args.transitionAnimationController,
        anchorPoint: args.anchorPoint,
        sheetAnimationStyle: args.sheetAnimationStyle,
      );
    },
  );
}

class AppModalBottomSheetRouteArgs {
  const AppModalBottomSheetRouteArgs({
    this.key,
    required this.builder,
    this.backgroundColor,
    this.barrierLabel,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.barrierColor,
    required this.isScrollControlled,
    required this.scrollControlDisabledMaxHeightRatio,
    required this.useRootNavigator,
    required this.isDismissible,
    required this.enableDrag,
    this.showDragHandle,
    required this.useSafeArea,
    this.routeSettings,
    this.transitionAnimationController,
    this.anchorPoint,
    this.sheetAnimationStyle,
  });

  final Key? key;

  final WidgetBuilder builder;

  final Color? backgroundColor;

  final String? barrierLabel;

  final double? elevation;

  final ShapeBorder? shape;

  final Clip? clipBehavior;

  final BoxConstraints? constraints;

  final Color? barrierColor;

  final bool isScrollControlled;

  final double scrollControlDisabledMaxHeightRatio;

  final bool useRootNavigator;

  final bool isDismissible;

  final bool enableDrag;

  final bool? showDragHandle;

  final bool useSafeArea;

  final RouteSettings? routeSettings;

  final AnimationController? transitionAnimationController;

  final Offset? anchorPoint;

  final AnimationStyle? sheetAnimationStyle;

  @override
  String toString() {
    return 'AppModalBottomSheetRouteArgs{key: $key, builder: $builder, backgroundColor: $backgroundColor, barrierLabel: $barrierLabel, elevation: $elevation, shape: $shape, clipBehavior: $clipBehavior, constraints: $constraints, barrierColor: $barrierColor, isScrollControlled: $isScrollControlled, scrollControlDisabledMaxHeightRatio: $scrollControlDisabledMaxHeightRatio, useRootNavigator: $useRootNavigator, isDismissible: $isDismissible, enableDrag: $enableDrag, showDragHandle: $showDragHandle, useSafeArea: $useSafeArea, routeSettings: $routeSettings, transitionAnimationController: $transitionAnimationController, anchorPoint: $anchorPoint, sheetAnimationStyle: $sheetAnimationStyle}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppModalBottomSheetRouteArgs) return false;
    return key == other.key &&
        builder == other.builder &&
        backgroundColor == other.backgroundColor &&
        barrierLabel == other.barrierLabel &&
        elevation == other.elevation &&
        shape == other.shape &&
        clipBehavior == other.clipBehavior &&
        constraints == other.constraints &&
        barrierColor == other.barrierColor &&
        isScrollControlled == other.isScrollControlled &&
        scrollControlDisabledMaxHeightRatio ==
            other.scrollControlDisabledMaxHeightRatio &&
        useRootNavigator == other.useRootNavigator &&
        isDismissible == other.isDismissible &&
        enableDrag == other.enableDrag &&
        showDragHandle == other.showDragHandle &&
        useSafeArea == other.useSafeArea &&
        routeSettings == other.routeSettings &&
        transitionAnimationController == other.transitionAnimationController &&
        anchorPoint == other.anchorPoint &&
        sheetAnimationStyle == other.sheetAnimationStyle;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      builder.hashCode ^
      backgroundColor.hashCode ^
      barrierLabel.hashCode ^
      elevation.hashCode ^
      shape.hashCode ^
      clipBehavior.hashCode ^
      constraints.hashCode ^
      barrierColor.hashCode ^
      isScrollControlled.hashCode ^
      scrollControlDisabledMaxHeightRatio.hashCode ^
      useRootNavigator.hashCode ^
      isDismissible.hashCode ^
      enableDrag.hashCode ^
      showDragHandle.hashCode ^
      useSafeArea.hashCode ^
      routeSettings.hashCode ^
      transitionAnimationController.hashCode ^
      anchorPoint.hashCode ^
      sheetAnimationStyle.hashCode;
}

/// generated route for
/// [ChatListScreen]
class ChatListRoute extends PageRouteInfo<void> {
  const ChatListRoute({List<PageRouteInfo>? children})
    : super(ChatListRoute.name, initialChildren: children);

  static const String name = 'ChatListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChatListScreen();
    },
  );
}

/// generated route for
/// [ChatScreen]
class ChatRoute extends PageRouteInfo<void> {
  const ChatRoute({List<PageRouteInfo>? children})
    : super(ChatRoute.name, initialChildren: children);

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChatScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreen();
    },
  );
}

/// generated route for
/// [PaywallScreen]
class PaywallRoute extends PageRouteInfo<void> {
  const PaywallRoute({List<PageRouteInfo>? children})
    : super(PaywallRoute.name, initialChildren: children);

  static const String name = 'PaywallRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PaywallScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [RealtimeCallScreen]
class RealtimeCallRoute extends PageRouteInfo<void> {
  const RealtimeCallRoute({List<PageRouteInfo>? children})
    : super(RealtimeCallRoute.name, initialChildren: children);

  static const String name = 'RealtimeCallRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RealtimeCallScreen();
    },
  );
}
