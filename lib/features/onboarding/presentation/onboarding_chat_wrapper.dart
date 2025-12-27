import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../core/local_storage/storage_keys.dart';
import '../../../core/localization/generated/l10n.dart';
import '../../../infrastructure/core.dart';

final _writeMessageKey = GlobalKey();
final _sendAudioMessageKey = GlobalKey();
final _startVoiceCallKey = GlobalKey();

const _scope = 'onboarding_chat_wrapper';

class OnboardingChatWrapper extends ConsumerStatefulWidget {
  const OnboardingChatWrapper({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<OnboardingChatWrapper> createState() =>
      _OnboardingChatListWrapperState();
}

class _OnboardingChatListWrapperState
    extends ConsumerState<OnboardingChatWrapper> {
  @override
  void initState() {
    super.initState();
    final showcaseView = ShowcaseView.register(scope: _scope);
    final localStorage = ref.read(localStorageProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final isOnboarded = await localStorage.getValue<bool>(
        StorageKeys.isOnboardedChatKey,
      );
      if (isOnboarded == true) {
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 300));
      showcaseView.startShowCase([_writeMessageKey]);
    });
  }

  @override
  void dispose() {
    ShowcaseView.getNamed(_scope).unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class WriteTextMessageWrapper extends ConsumerWidget {
  const WriteTextMessageWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      description: S.of(context).tapToWriteATextMessage,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(32),
      key: _writeMessageKey,
      onTargetClick: () async {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_sendAudioMessageKey]);
      },
      onBarrierClick: () async {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_sendAudioMessageKey]);
      },
      onToolTipClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_sendAudioMessageKey]);
      },
      disposeOnTap: true,
      tooltipActionConfig: const TooltipActionConfig(
        alignment: MainAxisAlignment.spaceBetween,
        actionGap: 16,
        position: TooltipActionPosition.outside,
        gapBetweenContentAndAction: 16,
      ),

      child: child,
    );
  }
}

class SendAudioMessageWrapper extends ConsumerWidget {
  const SendAudioMessageWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      description: S.of(context).orSendAnAudioMessage,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(32),
      key: _sendAudioMessageKey,
      onTargetClick: () async {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_startVoiceCallKey]);
      },
      onBarrierClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_startVoiceCallKey]);
      },
      onToolTipClick: () {
        final showcaseView = ShowcaseView.getNamed(_scope);
        showcaseView.startShowCase([_startVoiceCallKey]);
      },
      disposeOnTap: true,
      tooltipActionConfig: const TooltipActionConfig(
        alignment: MainAxisAlignment.spaceBetween,
        actionGap: 16,
        position: TooltipActionPosition.outside,
        gapBetweenContentAndAction: 16,
      ),

      child: child,
    );
  }
}

class StartVoiceCallWrapper extends ConsumerWidget {
  const StartVoiceCallWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Showcase(
      description: S.of(context).youCanAlsoPracticeSpeakingWithAVoiceCall,
      tooltipPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tooltipBorderRadius: BorderRadius.circular(16),
      targetBorderRadius: BorderRadius.circular(32),
      key: _startVoiceCallKey,
      onTargetClick: () async {
        ref
            .read(localStorageProvider)
            .setValue(StorageKeys.isOnboardedChatKey, true);
      },
      onBarrierClick: () {
        ref
            .read(localStorageProvider)
            .setValue(StorageKeys.isOnboardedChatKey, true);
      },
      onToolTipClick: () {
        ref
            .read(localStorageProvider)
            .setValue(StorageKeys.isOnboardedChatKey, true);
      },
      disposeOnTap: true,
      tooltipActionConfig: const TooltipActionConfig(
        alignment: MainAxisAlignment.spaceBetween,
        actionGap: 16,
        position: TooltipActionPosition.outside,
        gapBetweenContentAndAction: 16,
      ),

      child: child,
    );
  }
}
