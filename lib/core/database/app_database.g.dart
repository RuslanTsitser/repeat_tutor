// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastMessageMeta = const VerificationMeta(
    'lastMessage',
  );
  @override
  late final GeneratedColumn<String> lastMessage = GeneratedColumn<String>(
    'last_message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    lastMessage,
    time,
    unreadCount,
    avatarUrl,
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('last_message')) {
      context.handle(
        _lastMessageMeta,
        lastMessage.isAcceptableOrUnknown(
          data['last_message']!,
          _lastMessageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastMessageMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
        ),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chat(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      lastMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time'],
      )!,
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      )!,
    );
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }
}

class Chat extends DataClass implements Insertable<Chat> {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final String avatarUrl;
  const Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.avatarUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['last_message'] = Variable<String>(lastMessage);
    map['time'] = Variable<String>(time);
    map['unread_count'] = Variable<int>(unreadCount);
    map['avatar_url'] = Variable<String>(avatarUrl);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      id: Value(id),
      name: Value(name),
      lastMessage: Value(lastMessage),
      time: Value(time),
      unreadCount: Value(unreadCount),
      avatarUrl: Value(avatarUrl),
    );
  }

  factory Chat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastMessage: serializer.fromJson<String>(json['lastMessage']),
      time: serializer.fromJson<String>(json['time']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      avatarUrl: serializer.fromJson<String>(json['avatarUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'lastMessage': serializer.toJson<String>(lastMessage),
      'time': serializer.toJson<String>(time),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'avatarUrl': serializer.toJson<String>(avatarUrl),
    };
  }

  Chat copyWith({
    String? id,
    String? name,
    String? lastMessage,
    String? time,
    int? unreadCount,
    String? avatarUrl,
  }) => Chat(
    id: id ?? this.id,
    name: name ?? this.name,
    lastMessage: lastMessage ?? this.lastMessage,
    time: time ?? this.time,
    unreadCount: unreadCount ?? this.unreadCount,
    avatarUrl: avatarUrl ?? this.avatarUrl,
  );
  Chat copyWithCompanion(ChatsCompanion data) {
    return Chat(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      lastMessage: data.lastMessage.present
          ? data.lastMessage.value
          : this.lastMessage,
      time: data.time.present ? data.time.value : this.time,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('time: $time, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('avatarUrl: $avatarUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, lastMessage, time, unreadCount, avatarUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastMessage == this.lastMessage &&
          other.time == this.time &&
          other.unreadCount == this.unreadCount &&
          other.avatarUrl == this.avatarUrl);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> lastMessage;
  final Value<String> time;
  final Value<int> unreadCount;
  final Value<String> avatarUrl;
  final Value<int> rowid;
  const ChatsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastMessage = const Value.absent(),
    this.time = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatsCompanion.insert({
    required String id,
    required String name,
    required String lastMessage,
    required String time,
    this.unreadCount = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       lastMessage = Value(lastMessage),
       time = Value(time);
  static Insertable<Chat> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? lastMessage,
    Expression<String>? time,
    Expression<int>? unreadCount,
    Expression<String>? avatarUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastMessage != null) 'last_message': lastMessage,
      if (time != null) 'time': time,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? lastMessage,
    Value<String>? time,
    Value<int>? unreadCount,
    Value<String>? avatarUrl,
    Value<int>? rowid,
  }) {
    return ChatsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastMessage: lastMessage ?? this.lastMessage,
      time: time ?? this.time,
      unreadCount: unreadCount ?? this.unreadCount,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastMessage.present) {
      map['last_message'] = Variable<String>(lastMessage.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('time: $time, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('avatarUrl: $avatarUrl, ')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [id, message, isMe, time, chatId];
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      isMe: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_me'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chat_id'],
      )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final String id;
  final String message;
  final bool isMe;
  final String time;
  final String chatId;
  const Message({
    required this.id,
    required this.message,
    required this.isMe,
    required this.time,
    required this.chatId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['message'] = Variable<String>(message);
    map['is_me'] = Variable<bool>(isMe);
    map['time'] = Variable<String>(time);
    map['chat_id'] = Variable<String>(chatId);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      message: Value(message),
      isMe: Value(isMe),
      time: Value(time),
      chatId: Value(chatId),
    );
  }

  factory Message.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<String>(json['id']),
      message: serializer.fromJson<String>(json['message']),
      isMe: serializer.fromJson<bool>(json['isMe']),
      time: serializer.fromJson<String>(json['time']),
      chatId: serializer.fromJson<String>(json['chatId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'message': serializer.toJson<String>(message),
      'isMe': serializer.toJson<bool>(isMe),
      'time': serializer.toJson<String>(time),
      'chatId': serializer.toJson<String>(chatId),
    };
  }

  Message copyWith({
    String? id,
    String? message,
    bool? isMe,
    String? time,
    String? chatId,
  }) => Message(
    id: id ?? this.id,
    message: message ?? this.message,
    isMe: isMe ?? this.isMe,
    time: time ?? this.time,
    chatId: chatId ?? this.chatId,
  );
  Message copyWithCompanion(MessagesCompanion data) {
    return Message(
      id: data.id.present ? data.id.value : this.id,
      message: data.message.present ? data.message.value : this.message,
      isMe: data.isMe.present ? data.isMe.value : this.isMe,
      time: data.time.present ? data.time.value : this.time,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('isMe: $isMe, ')
          ..write('time: $time, ')
          ..write('chatId: $chatId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, message, isMe, time, chatId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.message == this.message &&
          other.isMe == this.isMe &&
          other.time == this.time &&
          other.chatId == this.chatId);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<String> id;
  final Value<String> message;
  final Value<bool> isMe;
  final Value<String> time;
  final Value<String> chatId;
  final Value<int> rowid;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.message = const Value.absent(),
    this.isMe = const Value.absent(),
    this.time = const Value.absent(),
    this.chatId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String id,
    required String message,
    required bool isMe,
    required String time,
    required String chatId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       message = Value(message),
       isMe = Value(isMe),
       time = Value(time),
       chatId = Value(chatId);
  static Insertable<Message> custom({
    Expression<String>? id,
    Expression<String>? message,
    Expression<bool>? isMe,
    Expression<String>? time,
    Expression<String>? chatId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (message != null) 'message': message,
      if (isMe != null) 'is_me': isMe,
      if (time != null) 'time': time,
      if (chatId != null) 'chat_id': chatId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? message,
    Value<bool>? isMe,
    Value<String>? time,
    Value<String>? chatId,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      message: message ?? this.message,
      isMe: isMe ?? this.isMe,
      time: time ?? this.time,
      chatId: chatId ?? this.chatId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (isMe.present) {
      map['is_me'] = Variable<bool>(isMe.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<String>(chatId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('message: $message, ')
          ..write('isMe: $isMe, ')
          ..write('time: $time, ')
          ..write('chatId: $chatId, ')
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
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _serverURLMeta = const VerificationMeta(
    'serverURL',
  );
  @override
  late final GeneratedColumn<String> serverURL = GeneratedColumn<String>(
    'server_u_r_l',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _callStartedAtMeta = const VerificationMeta(
    'callStartedAt',
  );
  @override
  late final GeneratedColumn<DateTime> callStartedAt =
      GeneratedColumn<DateTime>(
        'call_started_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _callDurationMinutesMeta =
      const VerificationMeta('callDurationMinutes');
  @override
  late final GeneratedColumn<int> callDurationMinutes = GeneratedColumn<int>(
    'call_duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    language,
    level,
    clientSecret,
    clientSecretExpiresAt,
    serverURL,
    callStartedAt,
    callDurationMinutes,
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
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
    if (data.containsKey('server_u_r_l')) {
      context.handle(
        _serverURLMeta,
        serverURL.isAcceptableOrUnknown(data['server_u_r_l']!, _serverURLMeta),
      );
    }
    if (data.containsKey('call_started_at')) {
      context.handle(
        _callStartedAtMeta,
        callStartedAt.isAcceptableOrUnknown(
          data['call_started_at']!,
          _callStartedAtMeta,
        ),
      );
    }
    if (data.containsKey('call_duration_minutes')) {
      context.handle(
        _callDurationMinutesMeta,
        callDurationMinutes.isAcceptableOrUnknown(
          data['call_duration_minutes']!,
          _callDurationMinutesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RealtimeSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RealtimeSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      ),
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      ),
      clientSecret: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_secret'],
      ),
      clientSecretExpiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}client_secret_expires_at'],
      ),
      serverURL: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}server_u_r_l'],
      ),
      callStartedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}call_started_at'],
      ),
      callDurationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}call_duration_minutes'],
      )!,
    );
  }

  @override
  $RealtimeSessionsTable createAlias(String alias) {
    return $RealtimeSessionsTable(attachedDatabase, alias);
  }
}

class RealtimeSession extends DataClass implements Insertable<RealtimeSession> {
  final String id;
  final DateTime createdAt;
  final String? language;
  final String? level;
  final String? clientSecret;
  final DateTime? clientSecretExpiresAt;
  final String? serverURL;
  final DateTime? callStartedAt;
  final int callDurationMinutes;
  const RealtimeSession({
    required this.id,
    required this.createdAt,
    this.language,
    this.level,
    this.clientSecret,
    this.clientSecretExpiresAt,
    this.serverURL,
    this.callStartedAt,
    required this.callDurationMinutes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    if (!nullToAbsent || level != null) {
      map['level'] = Variable<String>(level);
    }
    if (!nullToAbsent || clientSecret != null) {
      map['client_secret'] = Variable<String>(clientSecret);
    }
    if (!nullToAbsent || clientSecretExpiresAt != null) {
      map['client_secret_expires_at'] = Variable<DateTime>(
        clientSecretExpiresAt,
      );
    }
    if (!nullToAbsent || serverURL != null) {
      map['server_u_r_l'] = Variable<String>(serverURL);
    }
    if (!nullToAbsent || callStartedAt != null) {
      map['call_started_at'] = Variable<DateTime>(callStartedAt);
    }
    map['call_duration_minutes'] = Variable<int>(callDurationMinutes);
    return map;
  }

  RealtimeSessionsCompanion toCompanion(bool nullToAbsent) {
    return RealtimeSessionsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      level: level == null && nullToAbsent
          ? const Value.absent()
          : Value(level),
      clientSecret: clientSecret == null && nullToAbsent
          ? const Value.absent()
          : Value(clientSecret),
      clientSecretExpiresAt: clientSecretExpiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(clientSecretExpiresAt),
      serverURL: serverURL == null && nullToAbsent
          ? const Value.absent()
          : Value(serverURL),
      callStartedAt: callStartedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(callStartedAt),
      callDurationMinutes: Value(callDurationMinutes),
    );
  }

  factory RealtimeSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RealtimeSession(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      language: serializer.fromJson<String?>(json['language']),
      level: serializer.fromJson<String?>(json['level']),
      clientSecret: serializer.fromJson<String?>(json['clientSecret']),
      clientSecretExpiresAt: serializer.fromJson<DateTime?>(
        json['clientSecretExpiresAt'],
      ),
      serverURL: serializer.fromJson<String?>(json['serverURL']),
      callStartedAt: serializer.fromJson<DateTime?>(json['callStartedAt']),
      callDurationMinutes: serializer.fromJson<int>(
        json['callDurationMinutes'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'language': serializer.toJson<String?>(language),
      'level': serializer.toJson<String?>(level),
      'clientSecret': serializer.toJson<String?>(clientSecret),
      'clientSecretExpiresAt': serializer.toJson<DateTime?>(
        clientSecretExpiresAt,
      ),
      'serverURL': serializer.toJson<String?>(serverURL),
      'callStartedAt': serializer.toJson<DateTime?>(callStartedAt),
      'callDurationMinutes': serializer.toJson<int>(callDurationMinutes),
    };
  }

  RealtimeSession copyWith({
    String? id,
    DateTime? createdAt,
    Value<String?> language = const Value.absent(),
    Value<String?> level = const Value.absent(),
    Value<String?> clientSecret = const Value.absent(),
    Value<DateTime?> clientSecretExpiresAt = const Value.absent(),
    Value<String?> serverURL = const Value.absent(),
    Value<DateTime?> callStartedAt = const Value.absent(),
    int? callDurationMinutes,
  }) => RealtimeSession(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    language: language.present ? language.value : this.language,
    level: level.present ? level.value : this.level,
    clientSecret: clientSecret.present ? clientSecret.value : this.clientSecret,
    clientSecretExpiresAt: clientSecretExpiresAt.present
        ? clientSecretExpiresAt.value
        : this.clientSecretExpiresAt,
    serverURL: serverURL.present ? serverURL.value : this.serverURL,
    callStartedAt: callStartedAt.present
        ? callStartedAt.value
        : this.callStartedAt,
    callDurationMinutes: callDurationMinutes ?? this.callDurationMinutes,
  );
  RealtimeSession copyWithCompanion(RealtimeSessionsCompanion data) {
    return RealtimeSession(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      language: data.language.present ? data.language.value : this.language,
      level: data.level.present ? data.level.value : this.level,
      clientSecret: data.clientSecret.present
          ? data.clientSecret.value
          : this.clientSecret,
      clientSecretExpiresAt: data.clientSecretExpiresAt.present
          ? data.clientSecretExpiresAt.value
          : this.clientSecretExpiresAt,
      serverURL: data.serverURL.present ? data.serverURL.value : this.serverURL,
      callStartedAt: data.callStartedAt.present
          ? data.callStartedAt.value
          : this.callStartedAt,
      callDurationMinutes: data.callDurationMinutes.present
          ? data.callDurationMinutes.value
          : this.callDurationMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RealtimeSession(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('language: $language, ')
          ..write('level: $level, ')
          ..write('clientSecret: $clientSecret, ')
          ..write('clientSecretExpiresAt: $clientSecretExpiresAt, ')
          ..write('serverURL: $serverURL, ')
          ..write('callStartedAt: $callStartedAt, ')
          ..write('callDurationMinutes: $callDurationMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    language,
    level,
    clientSecret,
    clientSecretExpiresAt,
    serverURL,
    callStartedAt,
    callDurationMinutes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RealtimeSession &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.language == this.language &&
          other.level == this.level &&
          other.clientSecret == this.clientSecret &&
          other.clientSecretExpiresAt == this.clientSecretExpiresAt &&
          other.serverURL == this.serverURL &&
          other.callStartedAt == this.callStartedAt &&
          other.callDurationMinutes == this.callDurationMinutes);
}

class RealtimeSessionsCompanion extends UpdateCompanion<RealtimeSession> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String?> language;
  final Value<String?> level;
  final Value<String?> clientSecret;
  final Value<DateTime?> clientSecretExpiresAt;
  final Value<String?> serverURL;
  final Value<DateTime?> callStartedAt;
  final Value<int> callDurationMinutes;
  final Value<int> rowid;
  const RealtimeSessionsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.language = const Value.absent(),
    this.level = const Value.absent(),
    this.clientSecret = const Value.absent(),
    this.clientSecretExpiresAt = const Value.absent(),
    this.serverURL = const Value.absent(),
    this.callStartedAt = const Value.absent(),
    this.callDurationMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RealtimeSessionsCompanion.insert({
    required String id,
    required DateTime createdAt,
    this.language = const Value.absent(),
    this.level = const Value.absent(),
    this.clientSecret = const Value.absent(),
    this.clientSecretExpiresAt = const Value.absent(),
    this.serverURL = const Value.absent(),
    this.callStartedAt = const Value.absent(),
    this.callDurationMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt);
  static Insertable<RealtimeSession> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? language,
    Expression<String>? level,
    Expression<String>? clientSecret,
    Expression<DateTime>? clientSecretExpiresAt,
    Expression<String>? serverURL,
    Expression<DateTime>? callStartedAt,
    Expression<int>? callDurationMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (language != null) 'language': language,
      if (level != null) 'level': level,
      if (clientSecret != null) 'client_secret': clientSecret,
      if (clientSecretExpiresAt != null)
        'client_secret_expires_at': clientSecretExpiresAt,
      if (serverURL != null) 'server_u_r_l': serverURL,
      if (callStartedAt != null) 'call_started_at': callStartedAt,
      if (callDurationMinutes != null)
        'call_duration_minutes': callDurationMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RealtimeSessionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<String?>? language,
    Value<String?>? level,
    Value<String?>? clientSecret,
    Value<DateTime?>? clientSecretExpiresAt,
    Value<String?>? serverURL,
    Value<DateTime?>? callStartedAt,
    Value<int>? callDurationMinutes,
    Value<int>? rowid,
  }) {
    return RealtimeSessionsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      language: language ?? this.language,
      level: level ?? this.level,
      clientSecret: clientSecret ?? this.clientSecret,
      clientSecretExpiresAt:
          clientSecretExpiresAt ?? this.clientSecretExpiresAt,
      serverURL: serverURL ?? this.serverURL,
      callStartedAt: callStartedAt ?? this.callStartedAt,
      callDurationMinutes: callDurationMinutes ?? this.callDurationMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    if (serverURL.present) {
      map['server_u_r_l'] = Variable<String>(serverURL.value);
    }
    if (callStartedAt.present) {
      map['call_started_at'] = Variable<DateTime>(callStartedAt.value);
    }
    if (callDurationMinutes.present) {
      map['call_duration_minutes'] = Variable<int>(callDurationMinutes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RealtimeSessionsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('language: $language, ')
          ..write('level: $level, ')
          ..write('clientSecret: $clientSecret, ')
          ..write('clientSecretExpiresAt: $clientSecretExpiresAt, ')
          ..write('serverURL: $serverURL, ')
          ..write('callStartedAt: $callStartedAt, ')
          ..write('callDurationMinutes: $callDurationMinutes, ')
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
      required String id,
      required String name,
      required String lastMessage,
      required String time,
      Value<int> unreadCount,
      Value<String> avatarUrl,
      Value<int> rowid,
    });
typedef $$ChatsTableUpdateCompanionBuilder =
    ChatsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> lastMessage,
      Value<String> time,
      Value<int> unreadCount,
      Value<String> avatarUrl,
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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);
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
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> lastMessage = const Value.absent(),
                Value<String> time = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<String> avatarUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatsCompanion(
                id: id,
                name: name,
                lastMessage: lastMessage,
                time: time,
                unreadCount: unreadCount,
                avatarUrl: avatarUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String lastMessage,
                required String time,
                Value<int> unreadCount = const Value.absent(),
                Value<String> avatarUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatsCompanion.insert(
                id: id,
                name: name,
                lastMessage: lastMessage,
                time: time,
                unreadCount: unreadCount,
                avatarUrl: avatarUrl,
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
      required String id,
      required String message,
      required bool isMe,
      required String time,
      required String chatId,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<String> id,
      Value<String> message,
      Value<bool> isMe,
      Value<String> time,
      Value<String> chatId,
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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnFilters<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chatId => $composableBuilder(
    column: $table.chatId,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnOrderings<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chatId => $composableBuilder(
    column: $table.chatId,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<bool> get isMe =>
      $composableBuilder(column: $table.isMe, builder: (column) => column);

  GeneratedColumn<String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get chatId =>
      $composableBuilder(column: $table.chatId, builder: (column) => column);
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
                Value<String> id = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<bool> isMe = const Value.absent(),
                Value<String> time = const Value.absent(),
                Value<String> chatId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                message: message,
                isMe: isMe,
                time: time,
                chatId: chatId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String message,
                required bool isMe,
                required String time,
                required String chatId,
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                message: message,
                isMe: isMe,
                time: time,
                chatId: chatId,
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
      required String id,
      required DateTime createdAt,
      Value<String?> language,
      Value<String?> level,
      Value<String?> clientSecret,
      Value<DateTime?> clientSecretExpiresAt,
      Value<String?> serverURL,
      Value<DateTime?> callStartedAt,
      Value<int> callDurationMinutes,
      Value<int> rowid,
    });
typedef $$RealtimeSessionsTableUpdateCompanionBuilder =
    RealtimeSessionsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<String?> language,
      Value<String?> level,
      Value<String?> clientSecret,
      Value<DateTime?> clientSecretExpiresAt,
      Value<String?> serverURL,
      Value<DateTime?> callStartedAt,
      Value<int> callDurationMinutes,
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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnFilters<String> get serverURL => $composableBuilder(
    column: $table.serverURL,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get callStartedAt => $composableBuilder(
    column: $table.callStartedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get callDurationMinutes => $composableBuilder(
    column: $table.callDurationMinutes,
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnOrderings<String> get serverURL => $composableBuilder(
    column: $table.serverURL,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get callStartedAt => $composableBuilder(
    column: $table.callStartedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get callDurationMinutes => $composableBuilder(
    column: $table.callDurationMinutes,
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

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

  GeneratedColumn<String> get serverURL =>
      $composableBuilder(column: $table.serverURL, builder: (column) => column);

  GeneratedColumn<DateTime> get callStartedAt => $composableBuilder(
    column: $table.callStartedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get callDurationMinutes => $composableBuilder(
    column: $table.callDurationMinutes,
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
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> language = const Value.absent(),
                Value<String?> level = const Value.absent(),
                Value<String?> clientSecret = const Value.absent(),
                Value<DateTime?> clientSecretExpiresAt = const Value.absent(),
                Value<String?> serverURL = const Value.absent(),
                Value<DateTime?> callStartedAt = const Value.absent(),
                Value<int> callDurationMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RealtimeSessionsCompanion(
                id: id,
                createdAt: createdAt,
                language: language,
                level: level,
                clientSecret: clientSecret,
                clientSecretExpiresAt: clientSecretExpiresAt,
                serverURL: serverURL,
                callStartedAt: callStartedAt,
                callDurationMinutes: callDurationMinutes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                Value<String?> language = const Value.absent(),
                Value<String?> level = const Value.absent(),
                Value<String?> clientSecret = const Value.absent(),
                Value<DateTime?> clientSecretExpiresAt = const Value.absent(),
                Value<String?> serverURL = const Value.absent(),
                Value<DateTime?> callStartedAt = const Value.absent(),
                Value<int> callDurationMinutes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RealtimeSessionsCompanion.insert(
                id: id,
                createdAt: createdAt,
                language: language,
                level: level,
                clientSecret: clientSecret,
                clientSecretExpiresAt: clientSecretExpiresAt,
                serverURL: serverURL,
                callStartedAt: callStartedAt,
                callDurationMinutes: callDurationMinutes,
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
