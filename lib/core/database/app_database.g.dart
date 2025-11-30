// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<String> chatId = GeneratedColumn<String>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicMeta = const VerificationMeta('topic');
  @override
  late final GeneratedColumn<String> topic = GeneratedColumn<String>(
    'topic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    chatId,
    createdAt,
    language,
    level,
    topic,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chats';
  @override
  VerificationContext validateIntegrity(
    Insertable<Chat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('topic')) {
      context.handle(
        _topicMeta,
        topic.isAcceptableOrUnknown(data['topic']!, _topicMeta),
      );
    } else if (isInserting) {
      context.missing(_topicMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {chatId};
  @override
  Chat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chat(
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chat_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      topic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic'],
      )!,
    );
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }
}

class Chat extends DataClass implements Insertable<Chat> {
  final String chatId;
  final DateTime createdAt;
  final String language;
  final String level;
  final String topic;
  const Chat({
    required this.chatId,
    required this.createdAt,
    required this.language,
    required this.level,
    required this.topic,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chat_id'] = Variable<String>(chatId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['language'] = Variable<String>(language);
    map['level'] = Variable<String>(level);
    map['topic'] = Variable<String>(topic);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      chatId: Value(chatId),
      createdAt: Value(createdAt),
      language: Value(language),
      level: Value(level),
      topic: Value(topic),
    );
  }

  factory Chat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      chatId: serializer.fromJson<String>(json['chatId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      language: serializer.fromJson<String>(json['language']),
      level: serializer.fromJson<String>(json['level']),
      topic: serializer.fromJson<String>(json['topic']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'chatId': serializer.toJson<String>(chatId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'language': serializer.toJson<String>(language),
      'level': serializer.toJson<String>(level),
      'topic': serializer.toJson<String>(topic),
    };
  }

  Chat copyWith({
    String? chatId,
    DateTime? createdAt,
    String? language,
    String? level,
    String? topic,
  }) => Chat(
    chatId: chatId ?? this.chatId,
    createdAt: createdAt ?? this.createdAt,
    language: language ?? this.language,
    level: level ?? this.level,
    topic: topic ?? this.topic,
  );
  Chat copyWithCompanion(ChatsCompanion data) {
    return Chat(
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      language: data.language.present ? data.language.value : this.language,
      level: data.level.present ? data.level.value : this.level,
      topic: data.topic.present ? data.topic.value : this.topic,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('chatId: $chatId, ')
          ..write('createdAt: $createdAt, ')
          ..write('language: $language, ')
          ..write('level: $level, ')
          ..write('topic: $topic')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(chatId, createdAt, language, level, topic);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          other.chatId == this.chatId &&
          other.createdAt == this.createdAt &&
          other.language == this.language &&
          other.level == this.level &&
          other.topic == this.topic);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<String> chatId;
  final Value<DateTime> createdAt;
  final Value<String> language;
  final Value<String> level;
  final Value<String> topic;
  final Value<int> rowid;
  const ChatsCompanion({
    this.chatId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.language = const Value.absent(),
    this.level = const Value.absent(),
    this.topic = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatsCompanion.insert({
    required String chatId,
    this.createdAt = const Value.absent(),
    required String language,
    required String level,
    required String topic,
    this.rowid = const Value.absent(),
  }) : chatId = Value(chatId),
       language = Value(language),
       level = Value(level),
       topic = Value(topic);
  static Insertable<Chat> custom({
    Expression<String>? chatId,
    Expression<DateTime>? createdAt,
    Expression<String>? language,
    Expression<String>? level,
    Expression<String>? topic,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (chatId != null) 'chat_id': chatId,
      if (createdAt != null) 'created_at': createdAt,
      if (language != null) 'language': language,
      if (level != null) 'level': level,
      if (topic != null) 'topic': topic,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatsCompanion copyWith({
    Value<String>? chatId,
    Value<DateTime>? createdAt,
    Value<String>? language,
    Value<String>? level,
    Value<String>? topic,
    Value<int>? rowid,
  }) {
    return ChatsCompanion(
      chatId: chatId ?? this.chatId,
      createdAt: createdAt ?? this.createdAt,
      language: language ?? this.language,
      level: level ?? this.level,
      topic: topic ?? this.topic,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (chatId.present) {
      map['chat_id'] = Variable<String>(chatId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (topic.present) {
      map['topic'] = Variable<String>(topic.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsCompanion(')
          ..write('chatId: $chatId, ')
          ..write('createdAt: $createdAt, ')
          ..write('language: $language, ')
          ..write('level: $level, ')
          ..write('topic: $topic, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isMeMeta = const VerificationMeta('isMe');
  @override
  late final GeneratedColumn<bool> isMe = GeneratedColumn<bool>(
    'is_me',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_me" IN (0, 1))',
    ),
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<String> chatId = GeneratedColumn<String>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioPathMeta = const VerificationMeta(
    'audioPath',
  );
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
    'audio_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    messageId,
    createdAt,
    message,
    isMe,
    chatId,
    audioPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Message> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('is_me')) {
      context.handle(
        _isMeMeta,
        isMe.isAcceptableOrUnknown(data['is_me']!, _isMeMeta),
      );
    } else if (isInserting) {
      context.missing(_isMeMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('audio_path')) {
      context.handle(
        _audioPathMeta,
        audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {messageId};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      isMe: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_me'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chat_id'],
      )!,
      audioPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_path'],
      ),
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final String messageId;
  final DateTime createdAt;
  final String message;
  final bool isMe;
  final String chatId;
  final String? audioPath;
  const Message({
    required this.messageId,
    required this.createdAt,
    required this.message,
    required this.isMe,
    required this.chatId,
    this.audioPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<String>(messageId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['message'] = Variable<String>(message);
    map['is_me'] = Variable<bool>(isMe);
    map['chat_id'] = Variable<String>(chatId);
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      messageId: Value(messageId),
      createdAt: Value(createdAt),
      message: Value(message),
      isMe: Value(isMe),
      chatId: Value(chatId),
      audioPath: audioPath == null && nullToAbsent
          ? const Value.absent()
          : Value(audioPath),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      messageId: serializer.fromJson<String>(json['messageId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      message: serializer.fromJson<String>(json['message']),
      isMe: serializer.fromJson<bool>(json['isMe']),
      chatId: serializer.fromJson<String>(json['chatId']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'messageId': serializer.toJson<String>(messageId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'message': serializer.toJson<String>(message),
      'isMe': serializer.toJson<bool>(isMe),
      'chatId': serializer.toJson<String>(chatId),
      'audioPath': serializer.toJson<String?>(audioPath),
    };
  }

  Message copyWith({
    String? messageId,
    DateTime? createdAt,
    String? message,
    bool? isMe,
    String? chatId,
    Value<String?> audioPath = const Value.absent(),
  }) => Message(
    messageId: messageId ?? this.messageId,
    createdAt: createdAt ?? this.createdAt,
    message: message ?? this.message,
    isMe: isMe ?? this.isMe,
    chatId: chatId ?? this.chatId,
    audioPath: audioPath.present ? audioPath.value : this.audioPath,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      message: data.message.present ? data.message.value : this.message,
      isMe: data.isMe.present ? data.isMe.value : this.isMe,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('messageId: $messageId, ')
          ..write('createdAt: $createdAt, ')
          ..write('message: $message, ')
          ..write('isMe: $isMe, ')
          ..write('chatId: $chatId, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(messageId, createdAt, message, isMe, chatId, audioPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.messageId == this.messageId &&
          other.createdAt == this.createdAt &&
          other.message == this.message &&
          other.isMe == this.isMe &&
          other.chatId == this.chatId &&
          other.audioPath == this.audioPath);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> messageId;
  final Value<DateTime> createdAt;
  final Value<String> message;
  final Value<bool> isMe;
  final Value<String> chatId;
  final Value<String?> audioPath;
  final Value<int> rowid;
  const MessagesCompanion({
    this.messageId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.message = const Value.absent(),
    this.isMe = const Value.absent(),
    this.chatId = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String messageId,
    this.createdAt = const Value.absent(),
    required String message,
    required bool isMe,
    required String chatId,
    this.audioPath = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : messageId = Value(messageId),
       message = Value(message),
       isMe = Value(isMe),
       chatId = Value(chatId);
  static Insertable<Message> custom({
    Expression<String>? messageId,
    Expression<DateTime>? createdAt,
    Expression<String>? message,
    Expression<bool>? isMe,
    Expression<String>? chatId,
    Expression<String>? audioPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (createdAt != null) 'created_at': createdAt,
      if (message != null) 'message': message,
      if (isMe != null) 'is_me': isMe,
      if (chatId != null) 'chat_id': chatId,
      if (audioPath != null) 'audio_path': audioPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<String>? messageId,
    Value<DateTime>? createdAt,
    Value<String>? message,
    Value<bool>? isMe,
    Value<String>? chatId,
    Value<String?>? audioPath,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      messageId: messageId ?? this.messageId,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      isMe: isMe ?? this.isMe,
      chatId: chatId ?? this.chatId,
      audioPath: audioPath ?? this.audioPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (isMe.present) {
      map['is_me'] = Variable<bool>(isMe.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<String>(chatId.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('messageId: $messageId, ')
          ..write('createdAt: $createdAt, ')
          ..write('message: $message, ')
          ..write('isMe: $isMe, ')
          ..write('chatId: $chatId, ')
          ..write('audioPath: $audioPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RealtimeSessionsTable extends RealtimeSessions
    with TableInfo<$RealtimeSessionsTable, RealtimeSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RealtimeSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clientSecretMeta = const VerificationMeta(
    'clientSecret',
  );
  @override
  late final GeneratedColumn<String> clientSecret = GeneratedColumn<String>(
    'client_secret',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientSecretExpiresAtMeta =
      const VerificationMeta('clientSecretExpiresAt');
  @override
  late final GeneratedColumn<DateTime> clientSecretExpiresAt =
      GeneratedColumn<DateTime>(
        'client_secret_expires_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    sessionId,
    createdAt,
    language,
    level,
    clientSecret,
    clientSecretExpiresAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'realtime_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RealtimeSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('client_secret')) {
      context.handle(
        _clientSecretMeta,
        clientSecret.isAcceptableOrUnknown(
          data['client_secret']!,
          _clientSecretMeta,
        ),
      );
    }
    if (data.containsKey('client_secret_expires_at')) {
      context.handle(
        _clientSecretExpiresAtMeta,
        clientSecretExpiresAt.isAcceptableOrUnknown(
          data['client_secret_expires_at']!,
          _clientSecretExpiresAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {sessionId};
  @override
  RealtimeSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RealtimeSession(
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
      clientSecret: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_secret'],
      ),
      clientSecretExpiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}client_secret_expires_at'],
      ),
    );
  }

  @override
  $RealtimeSessionsTable createAlias(String alias) {
    return $RealtimeSessionsTable(attachedDatabase, alias);
  }
}

class RealtimeSession extends DataClass implements Insertable<RealtimeSession> {
  final String sessionId;
  final DateTime createdAt;
  final String language;
  final String level;
  final String? clientSecret;
  final DateTime? clientSecretExpiresAt;
  const RealtimeSession({
    required this.sessionId,
    required this.createdAt,
    required this.language,
    required this.level,
    this.clientSecret,
    this.clientSecretExpiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<String>(sessionId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['language'] = Variable<String>(language);
    map['level'] = Variable<String>(level);
    if (!nullToAbsent || clientSecret != null) {
      map['client_secret'] = Variable<String>(clientSecret);
    }
    if (!nullToAbsent || clientSecretExpiresAt != null) {
      map['client_secret_expires_at'] = Variable<DateTime>(
        clientSecretExpiresAt,
      );
    }
    return map;
  }

  RealtimeSessionsCompanion toCompanion(bool nullToAbsent) {
    return RealtimeSessionsCompanion(
      sessionId: Value(sessionId),
      createdAt: Value(createdAt),
      language: Value(language),
      level: Value(level),
      clientSecret: clientSecret == null && nullToAbsent
          ? const Value.absent()
          : Value(clientSecret),
      clientSecretExpiresAt: clientSecretExpiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(clientSecretExpiresAt),
    );
  }

  factory RealtimeSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RealtimeSession(
      sessionId: serializer.fromJson<String>(json['sessionId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      language: serializer.fromJson<String>(json['language']),
      level: serializer.fromJson<String>(json['level']),
      clientSecret: serializer.fromJson<String?>(json['clientSecret']),
      clientSecretExpiresAt: serializer.fromJson<DateTime?>(
        json['clientSecretExpiresAt'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<String>(sessionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'language': serializer.toJson<String>(language),
      'level': serializer.toJson<String>(level),
      'clientSecret': serializer.toJson<String?>(clientSecret),
      'clientSecretExpiresAt': serializer.toJson<DateTime?>(
        clientSecretExpiresAt,
      ),
    };
  }

  RealtimeSession copyWith({
    String? sessionId,
    DateTime? createdAt,
    String? language,
    String? level,
    Value<String?> clientSecret = const Value.absent(),
    Value<DateTime?> clientSecretExpiresAt = const Value.absent(),
  }) => RealtimeSession(
    sessionId: sessionId ?? this.sessionId,
    createdAt: createdAt ?? this.createdAt,
    language: language ?? this.language,
    level: level ?? this.level,
    clientSecret: clientSecret.present ? clientSecret.value : this.clientSecret,
    clientSecretExpiresAt: clientSecretExpiresAt.present
        ? clientSecretExpiresAt.value
        : this.clientSecretExpiresAt,
  );
  RealtimeSession copyWithCompanion(RealtimeSessionsCompanion data) {
    return RealtimeSession(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      language: data.language.present ? data.language.value : this.language,
      level: data.level.present ? data.level.value : this.level,
      clientSecret: data.clientSecret.present
          ? data.clientSecret.value
          : this.clientSecret,
      clientSecretExpiresAt: data.clientSecretExpiresAt.present
          ? data.clientSecretExpiresAt.value
          : this.clientSecretExpiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RealtimeSession(')
          ..write('sessionId: $sessionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('language: $language, ')
          ..write('level: $level, ')
          ..write('clientSecret: $clientSecret, ')
          ..write('clientSecretExpiresAt: $clientSecretExpiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    sessionId,
    createdAt,
    language,
    level,
    clientSecret,
    clientSecretExpiresAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RealtimeSession &&
          other.sessionId == this.sessionId &&
          other.createdAt == this.createdAt &&
          other.language == this.language &&
          other.level == this.level &&
          other.clientSecret == this.clientSecret &&
          other.clientSecretExpiresAt == this.clientSecretExpiresAt);
}

class RealtimeSessionsCompanion extends UpdateCompanion<RealtimeSession> {
  final Value<String> sessionId;
  final Value<DateTime> createdAt;
  final Value<String> language;
  final Value<String> level;
  final Value<String?> clientSecret;
  final Value<DateTime?> clientSecretExpiresAt;
  final Value<int> rowid;
  const RealtimeSessionsCompanion({
    this.sessionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.language = const Value.absent(),
    this.level = const Value.absent(),
    this.clientSecret = const Value.absent(),
    this.clientSecretExpiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RealtimeSessionsCompanion.insert({
    required String sessionId,
    required DateTime createdAt,
    required String language,
    required String level,
    this.clientSecret = const Value.absent(),
    this.clientSecretExpiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       createdAt = Value(createdAt),
       language = Value(language),
       level = Value(level);
  static Insertable<RealtimeSession> custom({
    Expression<String>? sessionId,
    Expression<DateTime>? createdAt,
    Expression<String>? language,
    Expression<String>? level,
    Expression<String>? clientSecret,
    Expression<DateTime>? clientSecretExpiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (createdAt != null) 'created_at': createdAt,
      if (language != null) 'language': language,
      if (level != null) 'level': level,
      if (clientSecret != null) 'client_secret': clientSecret,
      if (clientSecretExpiresAt != null)
        'client_secret_expires_at': clientSecretExpiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RealtimeSessionsCompanion copyWith({
    Value<String>? sessionId,
    Value<DateTime>? createdAt,
    Value<String>? language,
    Value<String>? level,
    Value<String?>? clientSecret,
    Value<DateTime?>? clientSecretExpiresAt,
    Value<int>? rowid,
  }) {
    return RealtimeSessionsCompanion(
      sessionId: sessionId ?? this.sessionId,
      createdAt: createdAt ?? this.createdAt,
      language: language ?? this.language,
      level: level ?? this.level,
      clientSecret: clientSecret ?? this.clientSecret,
      clientSecretExpiresAt:
          clientSecretExpiresAt ?? this.clientSecretExpiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (clientSecret.present) {
      map['client_secret'] = Variable<String>(clientSecret.value);
    }
    if (clientSecretExpiresAt.present) {
      map['client_secret_expires_at'] = Variable<DateTime>(
        clientSecretExpiresAt.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RealtimeSessionsCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('language: $language, ')
          ..write('level: $level, ')
          ..write('clientSecret: $clientSecret, ')
          ..write('clientSecretExpiresAt: $clientSecretExpiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ChatsTable chats = $ChatsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $RealtimeSessionsTable realtimeSessions = $RealtimeSessionsTable(
    this,
  );
  late final ChatDao chatDao = ChatDao(this as AppDatabase);
  late final MessageDao messageDao = MessageDao(this as AppDatabase);
  late final RealtimeSessionDao realtimeSessionDao = RealtimeSessionDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    chats,
    messages,
    realtimeSessions,
  ];
}

typedef $$ChatsTableCreateCompanionBuilder =
    ChatsCompanion Function({
      required String chatId,
      Value<DateTime> createdAt,
      required String language,
      required String level,
      required String topic,
      Value<int> rowid,
    });
typedef $$ChatsTableUpdateCompanionBuilder =
    ChatsCompanion Function({
      Value<String> chatId,
      Value<DateTime> createdAt,
      Value<String> language,
      Value<String> level,
      Value<String> topic,
      Value<int> rowid,
    });

class $$ChatsTableFilterComposer extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get chatId => $composableBuilder(
    column: $table.chatId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topic => $composableBuilder(
    column: $table.topic,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChatsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get chatId => $composableBuilder(
    column: $table.chatId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topic => $composableBuilder(
    column: $table.topic,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get chatId =>
      $composableBuilder(column: $table.chatId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get topic =>
      $composableBuilder(column: $table.topic, builder: (column) => column);
}

class $$ChatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatsTable,
          Chat,
          $$ChatsTableFilterComposer,
          $$ChatsTableOrderingComposer,
          $$ChatsTableAnnotationComposer,
          $$ChatsTableCreateCompanionBuilder,
          $$ChatsTableUpdateCompanionBuilder,
          (Chat, BaseReferences<_$AppDatabase, $ChatsTable, Chat>),
          Chat,
          PrefetchHooks Function()
        > {
  $$ChatsTableTableManager(_$AppDatabase db, $ChatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> chatId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String> topic = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatsCompanion(
                chatId: chatId,
                createdAt: createdAt,
                language: language,
                level: level,
                topic: topic,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String chatId,
                Value<DateTime> createdAt = const Value.absent(),
                required String language,
                required String level,
                required String topic,
                Value<int> rowid = const Value.absent(),
              }) => ChatsCompanion.insert(
                chatId: chatId,
                createdAt: createdAt,
                language: language,
                level: level,
                topic: topic,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatsTable,
      Chat,
      $$ChatsTableFilterComposer,
      $$ChatsTableOrderingComposer,
      $$ChatsTableAnnotationComposer,
      $$ChatsTableCreateCompanionBuilder,
      $$ChatsTableUpdateCompanionBuilder,
      (Chat, BaseReferences<_$AppDatabase, $ChatsTable, Chat>),
      Chat,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      required String messageId,
      Value<DateTime> createdAt,
      required String message,
      required bool isMe,
      required String chatId,
      Value<String?> audioPath,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<String> messageId,
      Value<DateTime> createdAt,
      Value<String> message,
      Value<bool> isMe,
      Value<String> chatId,
      Value<String?> audioPath,
      Value<int> rowid,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMe => $composableBuilder(
    column: $table.isMe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chatId => $composableBuilder(
    column: $table.chatId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMe => $composableBuilder(
    column: $table.isMe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chatId => $composableBuilder(
    column: $table.chatId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<bool> get isMe =>
      $composableBuilder(column: $table.isMe, builder: (column) => column);

  GeneratedColumn<String> get chatId =>
      $composableBuilder(column: $table.chatId, builder: (column) => column);

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          Message,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
          Message,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> messageId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<bool> isMe = const Value.absent(),
                Value<String> chatId = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                messageId: messageId,
                createdAt: createdAt,
                message: message,
                isMe: isMe,
                chatId: chatId,
                audioPath: audioPath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String messageId,
                Value<DateTime> createdAt = const Value.absent(),
                required String message,
                required bool isMe,
                required String chatId,
                Value<String?> audioPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                messageId: messageId,
                createdAt: createdAt,
                message: message,
                isMe: isMe,
                chatId: chatId,
                audioPath: audioPath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      Message,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (Message, BaseReferences<_$AppDatabase, $MessagesTable, Message>),
      Message,
      PrefetchHooks Function()
    >;
typedef $$RealtimeSessionsTableCreateCompanionBuilder =
    RealtimeSessionsCompanion Function({
      required String sessionId,
      required DateTime createdAt,
      required String language,
      required String level,
      Value<String?> clientSecret,
      Value<DateTime?> clientSecretExpiresAt,
      Value<int> rowid,
    });
typedef $$RealtimeSessionsTableUpdateCompanionBuilder =
    RealtimeSessionsCompanion Function({
      Value<String> sessionId,
      Value<DateTime> createdAt,
      Value<String> language,
      Value<String> level,
      Value<String?> clientSecret,
      Value<DateTime?> clientSecretExpiresAt,
      Value<int> rowid,
    });

class $$RealtimeSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $RealtimeSessionsTable> {
  $$RealtimeSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientSecret => $composableBuilder(
    column: $table.clientSecret,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get clientSecretExpiresAt => $composableBuilder(
    column: $table.clientSecretExpiresAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RealtimeSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RealtimeSessionsTable> {
  $$RealtimeSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientSecret => $composableBuilder(
    column: $table.clientSecret,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get clientSecretExpiresAt => $composableBuilder(
    column: $table.clientSecretExpiresAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RealtimeSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RealtimeSessionsTable> {
  $$RealtimeSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get clientSecret => $composableBuilder(
    column: $table.clientSecret,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get clientSecretExpiresAt => $composableBuilder(
    column: $table.clientSecretExpiresAt,
    builder: (column) => column,
  );
}

class $$RealtimeSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RealtimeSessionsTable,
          RealtimeSession,
          $$RealtimeSessionsTableFilterComposer,
          $$RealtimeSessionsTableOrderingComposer,
          $$RealtimeSessionsTableAnnotationComposer,
          $$RealtimeSessionsTableCreateCompanionBuilder,
          $$RealtimeSessionsTableUpdateCompanionBuilder,
          (
            RealtimeSession,
            BaseReferences<
              _$AppDatabase,
              $RealtimeSessionsTable,
              RealtimeSession
            >,
          ),
          RealtimeSession,
          PrefetchHooks Function()
        > {
  $$RealtimeSessionsTableTableManager(
    _$AppDatabase db,
    $RealtimeSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RealtimeSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RealtimeSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RealtimeSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> sessionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String?> clientSecret = const Value.absent(),
                Value<DateTime?> clientSecretExpiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RealtimeSessionsCompanion(
                sessionId: sessionId,
                createdAt: createdAt,
                language: language,
                level: level,
                clientSecret: clientSecret,
                clientSecretExpiresAt: clientSecretExpiresAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sessionId,
                required DateTime createdAt,
                required String language,
                required String level,
                Value<String?> clientSecret = const Value.absent(),
                Value<DateTime?> clientSecretExpiresAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RealtimeSessionsCompanion.insert(
                sessionId: sessionId,
                createdAt: createdAt,
                language: language,
                level: level,
                clientSecret: clientSecret,
                clientSecretExpiresAt: clientSecretExpiresAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RealtimeSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RealtimeSessionsTable,
      RealtimeSession,
      $$RealtimeSessionsTableFilterComposer,
      $$RealtimeSessionsTableOrderingComposer,
      $$RealtimeSessionsTableAnnotationComposer,
      $$RealtimeSessionsTableCreateCompanionBuilder,
      $$RealtimeSessionsTableUpdateCompanionBuilder,
      (
        RealtimeSession,
        BaseReferences<_$AppDatabase, $RealtimeSessionsTable, RealtimeSession>,
      ),
      RealtimeSession,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChatsTableTableManager get chats =>
      $$ChatsTableTableManager(_db, _db.chats);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$RealtimeSessionsTableTableManager get realtimeSessions =>
      $$RealtimeSessionsTableTableManager(_db, _db.realtimeSessions);
}
