import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../domain/models/chat.dart';
import '../../domain/models/message.dart';
import '../../domain/models/message_content_type.dart';
import '../../infrastructure/core.dart';
import '../../infrastructure/handlers.dart';
import '../../infrastructure/state_managers.dart';
import '../notifiers/message_notifier.dart';

@RoutePage()
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
    required this.chat,
  });
  final Chat chat;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final Record _recorder = Record();
  bool _isRecording = false;
  bool _isSending = false;
  String? _recordingPath;

  @override
  void initState() {
    super.initState();
    // Загружаем сообщения и отмечаем чат как прочитанный при открытии
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final messageEventHandler = ref.read(
        messageEventHandlerProvider(widget.chat.id),
      );
      messageEventHandler.onLoadMessagesPressed();
      final chatEventHandler = ref.read(chatEventHandlerProvider);
      chatEventHandler.onMarkAsReadPressed(widget.chat.id);
    });
  }

  Future<void> _sendTextMessage() async {
    if (_messageController.text.trim().isEmpty || _isSending) {
      return;
    }

    final messageText = _messageController.text.trim();
    _messageController.clear();

    await _performSend(() {
      final messageEventHandler = ref.read(
        messageEventHandlerProvider(widget.chat.id),
      );
      return messageEventHandler.onAddMessagePressed(messageText);
    });
  }

  Future<void> _sendVoiceMessage(String path) async {
    await _performSend(() {
      final messageEventHandler = ref.read(
        messageEventHandlerProvider(widget.chat.id),
      );
      return messageEventHandler.onAddVoiceMessagePressed(path);
    });
  }

  Future<void> _performSend(Future<void> Function() action) async {
    if (_isSending) return;
    setState(() {
      _isSending = true;
    });
    try {
      await action();
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      if (!mounted) return;
      setState(() {
        _isSending = false;
      });
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecordingAndSend();
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    if (_isSending) return;

    final permissionStatus = await Permission.microphone.request();
    if (!permissionStatus.isGranted) {
      _showErrorDialog(
        'Разрешите доступ к микрофону, чтобы записать сообщение.',
      );
      return;
    }

    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      _showErrorDialog('Нет доступа к микрофону');
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final fileName =
        'voice_${widget.chat.id}_${DateTime.now().microsecondsSinceEpoch}.m4a';
    final path = p.join(tempDir.path, fileName);

    await _recorder.start(
      path: path,
      encoder: AudioEncoder.aacLc,
      bitRate: 128000,
      samplingRate: 44100,
    );

    setState(() {
      _isRecording = true;
      _recordingPath = path;
    });
  }

  Future<void> _stopRecordingAndSend() async {
    final path = await _recorder.stop();
    final resolvedPath = path ?? _recordingPath;

    if (!mounted) {
      return;
    }

    setState(() {
      _isRecording = false;
      _recordingPath = null;
    });

    if (resolvedPath != null) {
      await _sendVoiceMessage(resolvedPath);
    }
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog<void>(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => ref.read(routerProvider).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messageNotifier = ref.watch<MessageNotifier>(
      messageProvider(widget.chat.id),
    );

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.chat.name),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () => ref.read(routerProvider).pop(),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.phone),
          onPressed: () {
            // Действие для звонка
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: messageNotifier.isLoading
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : messageNotifier.error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.exclamationmark_triangle,
                            size: 48,
                            color: CupertinoColors.systemRed,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Ошибка загрузки сообщений',
                            style: CupertinoTheme.of(
                              context,
                            ).textTheme.navTitleTextStyle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            messageNotifier.error!,
                            style: CupertinoTheme.of(
                              context,
                            ).textTheme.textStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          CupertinoButton.filled(
                            onPressed: () {
                              final messageEventHandler = ref.read(
                                messageEventHandlerProvider(widget.chat.id),
                              );
                              messageEventHandler.onLoadMessagesPressed();
                            },
                            child: const Text('Повторить'),
                          ),
                        ],
                      ),
                    )
                  : messageNotifier.messages.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.chat_bubble,
                            size: 48,
                            color: CupertinoColors.systemGrey,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Нет сообщений',
                            style: TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: messageNotifier.messages.length,
                      itemBuilder: (context, index) {
                        final message = messageNotifier.messages[index];
                        return _MessageBubble(
                          message: message,
                          chatName: widget.chat.name,
                        );
                      },
                    ),
            ),
            _MessageInput(
              controller: _messageController,
              onSendMessage: _sendTextMessage,
              onToggleRecording: _toggleRecording,
              isRecording: _isRecording,
              isSending: _isSending,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    if (_isRecording) {
      _recorder.stop();
    }
    unawaited(_recorder.dispose());
    super.dispose();
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    required this.message,
    required this.chatName,
  });
  final Message message;
  final String chatName;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = message.isMe
        ? CupertinoColors.systemBlue
        : CupertinoColors.systemGrey5;
    final textColor = message.isMe
        ? CupertinoColors.white
        : CupertinoColors.black;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: CupertinoColors.systemGrey4,
              child: Text(
                chatName[0].toUpperCase(),
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.hasAudio && message.audioPath != null)
                    VoiceMessagePlayer(
                      path: message.audioPath!,
                      isMe: message.isMe,
                    ),
                  if (message.text.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(
                        top: message.hasAudio ? 8 : 0,
                        bottom: 4,
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  if (message.contentType == MessageContentType.voice &&
                      message.transcription != null &&
                      message.transcription!.isNotEmpty &&
                      message.isMe)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        'Транскрипция: ${message.transcription}',
                        style: TextStyle(
                          color: textColor.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  if (message.hasCorrections && message.corrections != null)
                    _CorrectionsBlock(
                      text: message.corrections!,
                    ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      message.time,
                      style: TextStyle(
                        color: message.isMe
                            ? CupertinoColors.white.withOpacity(0.7)
                            : CupertinoColors.systemGrey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isMe) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 16,
              backgroundColor: CupertinoColors.systemBlue,
              child: Icon(
                CupertinoIcons.person_fill,
                color: CupertinoColors.white,
                size: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({
    required this.onSendMessage,
    required this.onToggleRecording,
    required this.controller,
    required this.isRecording,
    required this.isSending,
  });
  final VoidCallback onSendMessage;
  final VoidCallback onToggleRecording;
  final TextEditingController controller;
  final bool isRecording;
  final bool isSending;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: CupertinoColors.systemGrey6,
        border: Border(
          top: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          if (isRecording)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: CupertinoColors.systemRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.mic_fill,
                    color: CupertinoColors.systemRed,
                    size: 18,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Идет запись...',
                    style: TextStyle(
                      color: CupertinoColors.systemRed,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: CupertinoTextField(
                  controller: controller,
                  placeholder: 'Сообщение',
                  decoration: const BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  onSubmitted: (_) => onSendMessage(),
                  enabled: !isSending,
                ),
              ),
              const SizedBox(width: 8),
              CupertinoButton(
                padding: const EdgeInsets.all(8),
                onPressed: isSending ? null : onToggleRecording,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isRecording
                        ? CupertinoColors.systemRed
                        : CupertinoColors.systemGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isRecording
                        ? CupertinoIcons.stop_fill
                        : CupertinoIcons.mic_fill,
                    color: CupertinoColors.white,
                    size: 20,
                  ),
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.all(8),
                onPressed: isSending ? null : onSendMessage,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemBlue,
                    shape: BoxShape.circle,
                  ),
                  child: isSending
                      ? const CupertinoActivityIndicator(
                          color: CupertinoColors.white,
                        )
                      : const Icon(
                          CupertinoIcons.paperplane_fill,
                          color: CupertinoColors.white,
                          size: 20,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VoiceMessagePlayer extends StatefulWidget {
  const VoiceMessagePlayer({
    super.key,
    required this.path,
    required this.isMe,
  });

  final String path;
  final bool isMe;

  @override
  State<VoiceMessagePlayer> createState() => _VoiceMessagePlayerState();
}

class _VoiceMessagePlayerState extends State<VoiceMessagePlayer> {
  late final AudioPlayer _player;
  String? _loadedPath;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.playerStateStream.listen((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_player.playerState.playing) {
      await _player.pause();
      return;
    }

    if (_loadedPath != widget.path) {
      if (!File(widget.path).existsSync()) {
        return;
      }
      await _player.setFilePath(widget.path);
      _loadedPath = widget.path;
    }
    await _player.play();
  }

  @override
  Widget build(BuildContext context) {
    final isPlaying = _player.playerState.playing;
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: widget.isMe
              ? CupertinoColors.white.withOpacity(0.2)
              : CupertinoColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPlaying
                  ? CupertinoIcons.pause_circle
                  : CupertinoIcons.play_circle,
              color: widget.isMe
                  ? CupertinoColors.white
                  : CupertinoColors.systemBlue,
            ),
            const SizedBox(width: 8),
            Text(
              isPlaying ? 'Остановить' : 'Слушать аудио',
              style: TextStyle(
                color: widget.isMe
                    ? CupertinoColors.white
                    : CupertinoColors.systemBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CorrectionsBlock extends StatelessWidget {
  const _CorrectionsBlock({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CupertinoColors.systemYellow.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Правки',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: CupertinoColors.systemOrange,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: CupertinoColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
