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
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
    'chat_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _teacherLanguageMeta = const VerificationMeta(
    'teacherLanguage',
  );
  @override
  late final GeneratedColumn<String> teacherLanguage = GeneratedColumn<String>(
    'teacher_language',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    teacherLanguage,
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
    if (data.containsKey('teacher_language')) {
      context.handle(
        _teacherLanguageMeta,
        teacherLanguage.isAcceptableOrUnknown(
          data['teacher_language']!,
          _teacherLanguageMeta,
        ),
      );
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
        DriftSqlType.int,
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
      teacherLanguage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}teacher_language'],
      ),
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
  final int chatId;
  final DateTime createdAt;
  final String language;
  final String level;
  final String? teacherLanguage;
  final String topic;
  const Chat({
    required this.chatId,
    required this.createdAt,
    required this.language,
    required this.level,
    this.teacherLanguage,
    required this.topic,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chat_id'] = Variable<int>(chatId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['language'] = Variable<String>(language);
    map['level'] = Variable<String>(level);
    if (!nullToAbsent || teacherLanguage != null) {
      map['teacher_language'] = Variable<String>(teacherLanguage);
    }
    map['topic'] = Variable<String>(topic);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      chatId: Value(chatId),
      createdAt: Value(createdAt),
      language: Value(language),
      level: Value(level),
      teacherLanguage: teacherLanguage == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherLanguage),
      topic: Value(topic),
    );
  }

  factory Chat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      chatId: serializer.fromJson<int>(json['chatId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      language: serializer.fromJson<String>(json['language']),
      level: serializer.fromJson<String>(json['level']),
      teacherLanguage: serializer.fromJson<String?>(json['teacherLanguage']),
      topic: serializer.fromJson<String>(json['topic']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'chatId': serializer.toJson<int>(chatId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'language': serializer.toJson<String>(language),
      'level': serializer.toJson<String>(level),
      'teacherLanguage': serializer.toJson<String?>(teacherLanguage),
      'topic': serializer.toJson<String>(topic),
    };
  }

  Chat copyWith({
    int? chatId,
    DateTime? createdAt,
    String? language,
    String? level,
    Value<String?> teacherLanguage = const Value.absent(),
    String? topic,
  }) => Chat(
    chatId: chatId ?? this.chatId,
    createdAt: createdAt ?? this.createdAt,
    language: language ?? this.language,
    level: level ?? this.level,
    teacherLanguage: teacherLanguage.present
        ? teacherLanguage.value
        : this.teacherLanguage,
    topic: topic ?? this.topic,
  );
  Chat copyWithCompanion(ChatsCompanion data) {
    return Chat(
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      language: data.language.present ? data.language.value : this.language,
      level: data.level.present ? data.level.value : this.level,
      teacherLanguage: data.teacherLanguage.present
          ? data.teacherLanguage.value
          : this.teacherLanguage,
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
          ..write('teacherLanguage: $teacherLanguage, ')
          ..write('topic: $topic')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(chatId, createdAt, language, level, teacherLanguage, topic);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          other.chatId == this.chatId &&
          other.createdAt == this.createdAt &&
          other.language == this.language &&
          other.level == this.level &&
          other.teacherLanguage == this.teacherLanguage &&
          other.topic == this.topic);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<int> chatId;
  final Value<DateTime> createdAt;
  final Value<String> language;
  final Value<String> level;
  final Value<String?> teacherLanguage;
  final Value<String> topic;
  const ChatsCompanion({
    this.chatId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.language = const Value.absent(),
    this.level = const Value.absent(),
    this.teacherLanguage = const Value.absent(),
    this.topic = const Value.absent(),
  });
  ChatsCompanion.insert({
    this.chatId = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String language,
    required String level,
    this.teacherLanguage = const Value.absent(),
    required String topic,
  }) : language = Value(language),
       level = Value(level),
       topic = Value(topic);
  static Insertable<Chat> custom({
    Expression<int>? chatId,
    Expression<DateTime>? createdAt,
    Expression<String>? language,
    Expression<String>? level,
    Expression<String>? teacherLanguage,
    Expression<String>? topic,
  }) {
    return RawValuesInsertable({
      if (chatId != null) 'chat_id': chatId,
      if (createdAt != null) 'created_at': createdAt,
      if (language != null) 'language': language,
      if (level != null) 'level': level,
      if (teacherLanguage != null) 'teacher_language': teacherLanguage,
      if (topic != null) 'topic': topic,
    });
  }

  ChatsCompanion copyWith({
    Value<int>? chatId,
    Value<DateTime>? createdAt,
    Value<String>? language,
    Value<String>? level,
    Value<String?>? teacherLanguage,
    Value<String>? topic,
  }) {
    return ChatsCompanion(
      chatId: chatId ?? this.chatId,
      createdAt: createdAt ?? this.createdAt,
      language: language ?? this.language,
      level: level ?? this.level,
      teacherLanguage: teacherLanguage ?? this.teacherLanguage,
      topic: topic ?? this.topic,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
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
    if (teacherLanguage.present) {
      map['teacher_language'] = Variable<String>(teacherLanguage.value);
    }
    if (topic.present) {
      map['topic'] = Variable<String>(topic.value);
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
          ..write('teacherLanguage: $teacherLanguage, ')
          ..write('topic: $topic')
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
  late final GeneratedColumn<int> messageId = GeneratedColumn<int>(
    'message_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _gptResponseIdMeta = const VerificationMeta(
    'gptResponseId',
  );
  @override
  late final GeneratedColumn<String> gptResponseId = GeneratedColumn<String>(
    'gpt_response_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    chatId,
    createdAt,
    message,
    gptResponseId,
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
    }
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
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('gpt_response_id')) {
      context.handle(
        _gptResponseIdMeta,
        gptResponseId.isAcceptableOrUnknown(
          data['gpt_response_id']!,
          _gptResponseIdMeta,
        ),
      );
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
        DriftSqlType.int,
        data['${effectivePrefix}message_id'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      gptResponseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gpt_response_id'],
      ),
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
  final int messageId;
  final int chatId;
  final DateTime createdAt;
  final String message;
  final String? gptResponseId;
  final String? audioPath;
  const Message({
    required this.messageId,
    required this.chatId,
    required this.createdAt,
    required this.message,
    this.gptResponseId,
    this.audioPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<int>(messageId);
    map['chat_id'] = Variable<int>(chatId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || gptResponseId != null) {
      map['gpt_response_id'] = Variable<String>(gptResponseId);
    }
    if (!nullToAbsent || audioPath != null) {
      map['audio_path'] = Variable<String>(audioPath);
    }
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      messageId: Value(messageId),
      chatId: Value(chatId),
      createdAt: Value(createdAt),
      message: Value(message),
      gptResponseId: gptResponseId == null && nullToAbsent
          ? const Value.absent()
          : Value(gptResponseId),
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
      messageId: serializer.fromJson<int>(json['messageId']),
      chatId: serializer.fromJson<int>(json['chatId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      message: serializer.fromJson<String>(json['message']),
      gptResponseId: serializer.fromJson<String?>(json['gptResponseId']),
      audioPath: serializer.fromJson<String?>(json['audioPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'messageId': serializer.toJson<int>(messageId),
      'chatId': serializer.toJson<int>(chatId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'message': serializer.toJson<String>(message),
      'gptResponseId': serializer.toJson<String?>(gptResponseId),
      'audioPath': serializer.toJson<String?>(audioPath),
    };
  }

  Message copyWith({
    int? messageId,
    int? chatId,
    DateTime? createdAt,
    String? message,
    Value<String?> gptResponseId = const Value.absent(),
    Value<String?> audioPath = const Value.absent(),
  }) => Message(
    messageId: messageId ?? this.messageId,
    chatId: chatId ?? this.chatId,
    createdAt: createdAt ?? this.createdAt,
    message: message ?? this.message,
    gptResponseId: gptResponseId.present
        ? gptResponseId.value
        : this.gptResponseId,
    audioPath: audioPath.present ? audioPath.value : this.audioPath,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      message: data.message.present ? data.message.value : this.message,
      gptResponseId: data.gptResponseId.present
          ? data.gptResponseId.value
          : this.gptResponseId,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('messageId: $messageId, ')
          ..write('chatId: $chatId, ')
          ..write('createdAt: $createdAt, ')
          ..write('message: $message, ')
          ..write('gptResponseId: $gptResponseId, ')
          ..write('audioPath: $audioPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    messageId,
    chatId,
    createdAt,
    message,
    gptResponseId,
    audioPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.messageId == this.messageId &&
          other.chatId == this.chatId &&
          other.createdAt == this.createdAt &&
          other.message == this.message &&
          other.gptResponseId == this.gptResponseId &&
          other.audioPath == this.audioPath);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> messageId;
  final Value<int> chatId;
  final Value<DateTime> createdAt;
  final Value<String> message;
  final Value<String?> gptResponseId;
  final Value<String?> audioPath;
  const MessagesCompanion({
    this.messageId = const Value.absent(),
    this.chatId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.message = const Value.absent(),
    this.gptResponseId = const Value.absent(),
    this.audioPath = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.messageId = const Value.absent(),
    required int chatId,
    this.createdAt = const Value.absent(),
    required String message,
    this.gptResponseId = const Value.absent(),
    this.audioPath = const Value.absent(),
  }) : chatId = Value(chatId),
       message = Value(message);
  static Insertable<Message> custom({
    Expression<int>? messageId,
    Expression<int>? chatId,
    Expression<DateTime>? createdAt,
    Expression<String>? message,
    Expression<String>? gptResponseId,
    Expression<String>? audioPath,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (chatId != null) 'chat_id': chatId,
      if (createdAt != null) 'created_at': createdAt,
      if (message != null) 'message': message,
      if (gptResponseId != null) 'gpt_response_id': gptResponseId,
      if (audioPath != null) 'audio_path': audioPath,
    });
  }

  MessagesCompanion copyWith({
    Value<int>? messageId,
    Value<int>? chatId,
    Value<DateTime>? createdAt,
    Value<String>? message,
    Value<String?>? gptResponseId,
    Value<String?>? audioPath,
  }) {
    return MessagesCompanion(
      messageId: messageId ?? this.messageId,
      chatId: chatId ?? this.chatId,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      gptResponseId: gptResponseId ?? this.gptResponseId,
      audioPath: audioPath ?? this.audioPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (messageId.present) {
      map['message_id'] = Variable<int>(messageId.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (gptResponseId.present) {
      map['gpt_response_id'] = Variable<String>(gptResponseId.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('messageId: $messageId, ')
          ..write('chatId: $chatId, ')
          ..write('createdAt: $createdAt, ')
          ..write('message: $message, ')
          ..write('gptResponseId: $gptResponseId, ')
          ..write('audioPath: $audioPath')
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
  static const VerificationMeta _topicMeta = const VerificationMeta('topic');
  @override
  late final GeneratedColumn<String> topic = GeneratedColumn<String>(
    'topic',
    aliasedName,
    true,
    type: DriftSqlType.string,
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
    topic,
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
    if (data.containsKey('topic')) {
      context.handle(
        _topicMeta,
        topic.isAcceptableOrUnknown(data['topic']!, _topicMeta),
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
      topic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic'],
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
  final String? topic;
  const RealtimeSession({
    required this.sessionId,
    required this.createdAt,
    required this.language,
    required this.level,
    this.clientSecret,
    this.clientSecretExpiresAt,
    this.topic,
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
    if (!nullToAbsent || topic != null) {
      map['topic'] = Variable<String>(topic);
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
      topic: topic == null && nullToAbsent
          ? const Value.absent()
          : Value(topic),
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
      topic: serializer.fromJson<String?>(json['topic']),
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
      'topic': serializer.toJson<String?>(topic),
    };
  }

  RealtimeSession copyWith({
    String? sessionId,
    DateTime? createdAt,
    String? language,
    String? level,
    Value<String?> clientSecret = const Value.absent(),
    Value<DateTime?> clientSecretExpiresAt = const Value.absent(),
    Value<String?> topic = const Value.absent(),
  }) => RealtimeSession(
    sessionId: sessionId ?? this.sessionId,
    createdAt: createdAt ?? this.createdAt,
    language: language ?? this.language,
    level: level ?? this.level,
    clientSecret: clientSecret.present ? clientSecret.value : this.clientSecret,
    clientSecretExpiresAt: clientSecretExpiresAt.present
        ? clientSecretExpiresAt.value
        : this.clientSecretExpiresAt,
    topic: topic.present ? topic.value : this.topic,
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
      topic: data.topic.present ? data.topic.value : this.topic,
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
          ..write('clientSecretExpiresAt: $clientSecretExpiresAt, ')
          ..write('topic: $topic')
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
    topic,
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
          other.clientSecretExpiresAt == this.clientSecretExpiresAt &&
          other.topic == this.topic);
}

class RealtimeSessionsCompanion extends UpdateCompanion<RealtimeSession> {
  final Value<String> sessionId;
  final Value<DateTime> createdAt;
  final Value<String> language;
  final Value<String> level;
  final Value<String?> clientSecret;
  final Value<DateTime?> clientSecretExpiresAt;
  final Value<String?> topic;
  final Value<int> rowid;
  const RealtimeSessionsCompanion({
    this.sessionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.language = const Value.absent(),
    this.level = const Value.absent(),
    this.clientSecret = const Value.absent(),
    this.clientSecretExpiresAt = const Value.absent(),
    this.topic = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RealtimeSessionsCompanion.insert({
    required String sessionId,
    this.createdAt = const Value.absent(),
    required String language,
    required String level,
    this.clientSecret = const Value.absent(),
    this.clientSecretExpiresAt = const Value.absent(),
    this.topic = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId),
       language = Value(language),
       level = Value(level);
  static Insertable<RealtimeSession> custom({
    Expression<String>? sessionId,
    Expression<DateTime>? createdAt,
    Expression<String>? language,
    Expression<String>? level,
    Expression<String>? clientSecret,
    Expression<DateTime>? clientSecretExpiresAt,
    Expression<String>? topic,
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
      if (topic != null) 'topic': topic,
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
    Value<String?>? topic,
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
      topic: topic ?? this.topic,
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
    return (StringBuffer('RealtimeSessionsCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('language: $language, ')
          ..write('level: $level, ')
          ..write('clientSecret: $clientSecret, ')
          ..write('clientSecretExpiresAt: $clientSecretExpiresAt, ')
          ..write('topic: $topic, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsDurationsTable extends SessionsDurations
    with TableInfo<$SessionsDurationsTable, SessionsDuration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsDurationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _durationInMillisecondsMeta =
      const VerificationMeta('durationInMilliseconds');
  @override
  late final GeneratedColumn<int> durationInMilliseconds = GeneratedColumn<int>(
    'duration_in_milliseconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    sessionId,
    createdAt,
    durationInMilliseconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions_durations';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionsDuration> instance, {
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
    }
    if (data.containsKey('duration_in_milliseconds')) {
      context.handle(
        _durationInMillisecondsMeta,
        durationInMilliseconds.isAcceptableOrUnknown(
          data['duration_in_milliseconds']!,
          _durationInMillisecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  SessionsDuration map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionsDuration(
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      durationInMilliseconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_in_milliseconds'],
      )!,
    );
  }

  @override
  $SessionsDurationsTable createAlias(String alias) {
    return $SessionsDurationsTable(attachedDatabase, alias);
  }
}

class SessionsDuration extends DataClass
    implements Insertable<SessionsDuration> {
  final int sessionId;
  final DateTime createdAt;
  final int durationInMilliseconds;
  const SessionsDuration({
    required this.sessionId,
    required this.createdAt,
    required this.durationInMilliseconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['session_id'] = Variable<int>(sessionId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['duration_in_milliseconds'] = Variable<int>(durationInMilliseconds);
    return map;
  }

  SessionsDurationsCompanion toCompanion(bool nullToAbsent) {
    return SessionsDurationsCompanion(
      sessionId: Value(sessionId),
      createdAt: Value(createdAt),
      durationInMilliseconds: Value(durationInMilliseconds),
    );
  }

  factory SessionsDuration.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionsDuration(
      sessionId: serializer.fromJson<int>(json['sessionId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      durationInMilliseconds: serializer.fromJson<int>(
        json['durationInMilliseconds'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sessionId': serializer.toJson<int>(sessionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'durationInMilliseconds': serializer.toJson<int>(durationInMilliseconds),
    };
  }

  SessionsDuration copyWith({
    int? sessionId,
    DateTime? createdAt,
    int? durationInMilliseconds,
  }) => SessionsDuration(
    sessionId: sessionId ?? this.sessionId,
    createdAt: createdAt ?? this.createdAt,
    durationInMilliseconds:
        durationInMilliseconds ?? this.durationInMilliseconds,
  );
  SessionsDuration copyWithCompanion(SessionsDurationsCompanion data) {
    return SessionsDuration(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      durationInMilliseconds: data.durationInMilliseconds.present
          ? data.durationInMilliseconds.value
          : this.durationInMilliseconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionsDuration(')
          ..write('sessionId: $sessionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('durationInMilliseconds: $durationInMilliseconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sessionId, createdAt, durationInMilliseconds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionsDuration &&
          other.sessionId == this.sessionId &&
          other.createdAt == this.createdAt &&
          other.durationInMilliseconds == this.durationInMilliseconds);
}

class SessionsDurationsCompanion extends UpdateCompanion<SessionsDuration> {
  final Value<int> sessionId;
  final Value<DateTime> createdAt;
  final Value<int> durationInMilliseconds;
  final Value<int> rowid;
  const SessionsDurationsCompanion({
    this.sessionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.durationInMilliseconds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsDurationsCompanion.insert({
    required int sessionId,
    this.createdAt = const Value.absent(),
    this.durationInMilliseconds = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : sessionId = Value(sessionId);
  static Insertable<SessionsDuration> custom({
    Expression<int>? sessionId,
    Expression<DateTime>? createdAt,
    Expression<int>? durationInMilliseconds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (sessionId != null) 'session_id': sessionId,
      if (createdAt != null) 'created_at': createdAt,
      if (durationInMilliseconds != null)
        'duration_in_milliseconds': durationInMilliseconds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsDurationsCompanion copyWith({
    Value<int>? sessionId,
    Value<DateTime>? createdAt,
    Value<int>? durationInMilliseconds,
    Value<int>? rowid,
  }) {
    return SessionsDurationsCompanion(
      sessionId: sessionId ?? this.sessionId,
      createdAt: createdAt ?? this.createdAt,
      durationInMilliseconds:
          durationInMilliseconds ?? this.durationInMilliseconds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (durationInMilliseconds.present) {
      map['duration_in_milliseconds'] = Variable<int>(
        durationInMilliseconds.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsDurationsCompanion(')
          ..write('sessionId: $sessionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('durationInMilliseconds: $durationInMilliseconds, ')
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
  late final $SessionsDurationsTable sessionsDurations =
      $SessionsDurationsTable(this);
  late final ChatDao chatDao = ChatDao(this as AppDatabase);
  late final MessageDao messageDao = MessageDao(this as AppDatabase);
  late final RealtimeSessionDao realtimeSessionDao = RealtimeSessionDao(
    this as AppDatabase,
  );
  late final SessionsDurationsDao sessionsDurationsDao = SessionsDurationsDao(
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
    sessionsDurations,
  ];
}

typedef $$ChatsTableCreateCompanionBuilder =
    ChatsCompanion Function({
      Value<int> chatId,
      Value<DateTime> createdAt,
      required String language,
      required String level,
      Value<String?> teacherLanguage,
      required String topic,
    });
typedef $$ChatsTableUpdateCompanionBuilder =
    ChatsCompanion Function({
      Value<int> chatId,
      Value<DateTime> createdAt,
      Value<String> language,
      Value<String> level,
      Value<String?> teacherLanguage,
      Value<String> topic,
    });

class $$ChatsTableFilterComposer extends Composer<_$AppDatabase, $ChatsTable> {
  $$ChatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get chatId => $composableBuilder(
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

  ColumnFilters<String> get teacherLanguage => $composableBuilder(
    column: $table.teacherLanguage,
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
  ColumnOrderings<int> get chatId => $composableBuilder(
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

  ColumnOrderings<String> get teacherLanguage => $composableBuilder(
    column: $table.teacherLanguage,
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
  GeneratedColumn<int> get chatId =>
      $composableBuilder(column: $table.chatId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get teacherLanguage => $composableBuilder(
    column: $table.teacherLanguage,
    builder: (column) => column,
  );

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
                Value<int> chatId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<String?> teacherLanguage = const Value.absent(),
                Value<String> topic = const Value.absent(),
              }) => ChatsCompanion(
                chatId: chatId,
                createdAt: createdAt,
                language: language,
                level: level,
                teacherLanguage: teacherLanguage,
                topic: topic,
              ),
          createCompanionCallback:
              ({
                Value<int> chatId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                required String language,
                required String level,
                Value<String?> teacherLanguage = const Value.absent(),
                required String topic,
              }) => ChatsCompanion.insert(
                chatId: chatId,
                createdAt: createdAt,
                language: language,
                level: level,
                teacherLanguage: teacherLanguage,
                topic: topic,
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
      Value<int> messageId,
      required int chatId,
      Value<DateTime> createdAt,
      required String message,
      Value<String?> gptResponseId,
      Value<String?> audioPath,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> messageId,
      Value<int> chatId,
      Value<DateTime> createdAt,
      Value<String> message,
      Value<String?> gptResponseId,
      Value<String?> audioPath,
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
  ColumnFilters<int> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chatId => $composableBuilder(
    column: $table.chatId,
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

  ColumnFilters<String> get gptResponseId => $composableBuilder(
    column: $table.gptResponseId,
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
  ColumnOrderings<int> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chatId => $composableBuilder(
    column: $table.chatId,
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

  ColumnOrderings<String> get gptResponseId => $composableBuilder(
    column: $table.gptResponseId,
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
  GeneratedColumn<int> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<int> get chatId =>
      $composableBuilder(column: $table.chatId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get gptResponseId => $composableBuilder(
    column: $table.gptResponseId,
    builder: (column) => column,
  );

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
                Value<int> messageId = const Value.absent(),
                Value<int> chatId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String?> gptResponseId = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
              }) => MessagesCompanion(
                messageId: messageId,
                chatId: chatId,
                createdAt: createdAt,
                message: message,
                gptResponseId: gptResponseId,
                audioPath: audioPath,
              ),
          createCompanionCallback:
              ({
                Value<int> messageId = const Value.absent(),
                required int chatId,
                Value<DateTime> createdAt = const Value.absent(),
                required String message,
                Value<String?> gptResponseId = const Value.absent(),
                Value<String?> audioPath = const Value.absent(),
              }) => MessagesCompanion.insert(
                messageId: messageId,
                chatId: chatId,
                createdAt: createdAt,
                message: message,
                gptResponseId: gptResponseId,
                audioPath: audioPath,
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
      Value<DateTime> createdAt,
      required String language,
      required String level,
      Value<String?> clientSecret,
      Value<DateTime?> clientSecretExpiresAt,
      Value<String?> topic,
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
      Value<String?> topic,
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

  ColumnFilters<String> get topic => $composableBuilder(
    column: $table.topic,
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

  ColumnOrderings<String> get topic => $composableBuilder(
    column: $table.topic,
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

  GeneratedColumn<String> get topic =>
      $composableBuilder(column: $table.topic, builder: (column) => column);
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
                Value<String?> topic = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RealtimeSessionsCompanion(
                sessionId: sessionId,
                createdAt: createdAt,
                language: language,
                level: level,
                clientSecret: clientSecret,
                clientSecretExpiresAt: clientSecretExpiresAt,
                topic: topic,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String sessionId,
                Value<DateTime> createdAt = const Value.absent(),
                required String language,
                required String level,
                Value<String?> clientSecret = const Value.absent(),
                Value<DateTime?> clientSecretExpiresAt = const Value.absent(),
                Value<String?> topic = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RealtimeSessionsCompanion.insert(
                sessionId: sessionId,
                createdAt: createdAt,
                language: language,
                level: level,
                clientSecret: clientSecret,
                clientSecretExpiresAt: clientSecretExpiresAt,
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
typedef $$SessionsDurationsTableCreateCompanionBuilder =
    SessionsDurationsCompanion Function({
      required int sessionId,
      Value<DateTime> createdAt,
      Value<int> durationInMilliseconds,
      Value<int> rowid,
    });
typedef $$SessionsDurationsTableUpdateCompanionBuilder =
    SessionsDurationsCompanion Function({
      Value<int> sessionId,
      Value<DateTime> createdAt,
      Value<int> durationInMilliseconds,
      Value<int> rowid,
    });

class $$SessionsDurationsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsDurationsTable> {
  $$SessionsDurationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationInMilliseconds => $composableBuilder(
    column: $table.durationInMilliseconds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionsDurationsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsDurationsTable> {
  $$SessionsDurationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationInMilliseconds => $composableBuilder(
    column: $table.durationInMilliseconds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsDurationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsDurationsTable> {
  $$SessionsDurationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get durationInMilliseconds => $composableBuilder(
    column: $table.durationInMilliseconds,
    builder: (column) => column,
  );
}

class $$SessionsDurationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsDurationsTable,
          SessionsDuration,
          $$SessionsDurationsTableFilterComposer,
          $$SessionsDurationsTableOrderingComposer,
          $$SessionsDurationsTableAnnotationComposer,
          $$SessionsDurationsTableCreateCompanionBuilder,
          $$SessionsDurationsTableUpdateCompanionBuilder,
          (
            SessionsDuration,
            BaseReferences<
              _$AppDatabase,
              $SessionsDurationsTable,
              SessionsDuration
            >,
          ),
          SessionsDuration,
          PrefetchHooks Function()
        > {
  $$SessionsDurationsTableTableManager(
    _$AppDatabase db,
    $SessionsDurationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsDurationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsDurationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsDurationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> sessionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> durationInMilliseconds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsDurationsCompanion(
                sessionId: sessionId,
                createdAt: createdAt,
                durationInMilliseconds: durationInMilliseconds,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int sessionId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> durationInMilliseconds = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsDurationsCompanion.insert(
                sessionId: sessionId,
                createdAt: createdAt,
                durationInMilliseconds: durationInMilliseconds,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionsDurationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsDurationsTable,
      SessionsDuration,
      $$SessionsDurationsTableFilterComposer,
      $$SessionsDurationsTableOrderingComposer,
      $$SessionsDurationsTableAnnotationComposer,
      $$SessionsDurationsTableCreateCompanionBuilder,
      $$SessionsDurationsTableUpdateCompanionBuilder,
      (
        SessionsDuration,
        BaseReferences<
          _$AppDatabase,
          $SessionsDurationsTable,
          SessionsDuration
        >,
      ),
      SessionsDuration,
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
  $$SessionsDurationsTableTableManager get sessionsDurations =>
      $$SessionsDurationsTableTableManager(_db, _db.sessionsDurations);
}
