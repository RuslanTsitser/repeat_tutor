import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/models/chat.dart';
import '../../domain/models/realtime_session.dart';
import '../../presentation/screens/chat_list_screen.dart';
import '../../presentation/screens/chat_screen.dart';
import '../../presentation/screens/create_chat_screen.dart';
import '../../presentation/screens/create_realtime_session_screen.dart';
import '../../presentation/screens/initialize_screen.dart';
import '../../presentation/screens/realtime_session_detail_screen.dart';
import '../../presentation/screens/realtime_session_list_screen.dart';
import 'modal_screens/app_bottom_sheet_screen.dart';
import 'modal_screens/app_dialog_screen.dart';
import 'modal_screens/app_full_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: InitializeRoute.page, initial: true),
    AutoRoute(page: ChatListRoute.page),
    AutoRoute(page: ChatRoute.page),
    AutoRoute(page: RealtimeSessionListRoute.page),
    AutoRoute(page: RealtimeSessionDetailRoute.page),
    AutoRoute(page: CreateChatRoute.page),
    AutoRoute(page: CreateRealtimeSessionRoute.page),
    CustomRoute<void>(
      page: AppDialogRoute.page,
      fullscreenDialog: true,
      customRouteBuilder: _buildAppDialog,
    ),
    CustomRoute<void>(
      page: AppModalBottomSheetRoute.page,
      fullscreenDialog: true,
      customRouteBuilder: _buildAppModalBottomSheet,
    ),
    CustomRoute<void>(
      page: AppFullRoute.page,
      fullscreenDialog: true,
      customRouteBuilder: _buildAppFullScreen,
    ),
  ];

  Route<T> _buildAppModalBottomSheet<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<dynamic> page,
  ) {
    final MaterialLocalizations localizations = MaterialLocalizations.of(
      context,
    );
    final widget = page.child as AppModalBottomSheetScreen;
    return ModalBottomSheetRoute(
      builder: widget.builder,
      isScrollControlled: widget.isScrollControlled,
      scrollControlDisabledMaxHeightRatio:
          widget.scrollControlDisabledMaxHeightRatio,
      barrierLabel: widget.barrierLabel ?? localizations.scrimLabel,
      barrierOnTapHint: localizations.scrimOnTapHint(
        localizations.bottomSheetLabel,
      ),
      backgroundColor: widget.backgroundColor,
      elevation: widget.elevation,
      shape: widget.shape,
      clipBehavior: widget.clipBehavior,
      constraints: widget.constraints,
      isDismissible: widget.isDismissible,
      modalBarrierColor:
          widget.barrierColor ??
          Theme.of(context).bottomSheetTheme.modalBarrierColor,
      enableDrag: widget.enableDrag,
      showDragHandle: widget.showDragHandle,
      settings: page,
      anchorPoint: widget.anchorPoint,
      useSafeArea: widget.useSafeArea,
    );
  }

  Route<T> _buildAppDialog<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<dynamic> page,
  ) {
    final widget = page.child as AppDialogScreen;
    return defaultTargetPlatform == TargetPlatform.iOS
        ? CupertinoDialogRoute(
            barrierDismissible: widget.barrierDismissible,
            settings: page,
            context: context,
            builder: (context) => child,
          )
        : DialogRoute(
            barrierDismissible: widget.barrierDismissible,
            settings: page,
            context: context,
            builder: (context) => child,
          );
  }

  Route<T> _buildAppFullScreen<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<dynamic> page,
  ) {
    final widget = page.child as AppFullScreen;
    return MaterialPageRoute(
      builder: widget.builder,
      settings: page,
    );
  }
}
