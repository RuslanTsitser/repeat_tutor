// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ChatsTable extends Chats with TableInfo<$ChatsTable, ChatDb> {
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
    Insertable<ChatDb> instance, {
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
    } else if (isInserting) {
      context.missing(_teacherLanguageMeta);
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
  ChatDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatDb(
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

class ChatDb extends DataClass implements Insertable<ChatDb> {
  final int chatId;
  final DateTime createdAt;
  final String language;
  final String level;
  final String teacherLanguage;
  final String topic;
  const ChatDb({
    required this.chatId,
    required this.createdAt,
    required this.language,
    required this.level,
    required this.teacherLanguage,
    required this.topic,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chat_id'] = Variable<int>(chatId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['language'] = Variable<String>(language);
    map['level'] = Variable<String>(level);
    map['teacher_language'] = Variable<String>(teacherLanguage);
    map['topic'] = Variable<String>(topic);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      chatId: Value(chatId),
      createdAt: Value(createdAt),
      language: Value(language),
      level: Value(level),
      teacherLanguage: Value(teacherLanguage),
      topic: Value(topic),
    );
  }

  factory ChatDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatDb(
      chatId: serializer.fromJson<int>(json['chatId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      language: serializer.fromJson<String>(json['language']),
      level: serializer.fromJson<String>(json['level']),
      teacherLanguage: serializer.fromJson<String>(json['teacherLanguage']),
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
      'teacherLanguage': serializer.toJson<String>(teacherLanguage),
      'topic': serializer.toJson<String>(topic),
    };
  }

  ChatDb copyWith({
    int? chatId,
    DateTime? createdAt,
    String? language,
    String? level,
    String? teacherLanguage,
    String? topic,
  }) => ChatDb(
    chatId: chatId ?? this.chatId,
    createdAt: createdAt ?? this.createdAt,
    language: language ?? this.language,
    level: level ?? this.level,
    teacherLanguage: teacherLanguage ?? this.teacherLanguage,
    topic: topic ?? this.topic,
  );
  ChatDb copyWithCompanion(ChatsCompanion data) {
    return ChatDb(
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
    return (StringBuffer('ChatDb(')
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
      (other is ChatDb &&
          other.chatId == this.chatId &&
          other.createdAt == this.createdAt &&
          other.language == this.language &&
          other.level == this.level &&
          other.teacherLanguage == this.teacherLanguage &&
          other.topic == this.topic);
}

class ChatsCompanion extends UpdateCompanion<ChatDb> {
  final Value<int> chatId;
  final Value<DateTime> createdAt;
  final Value<String> language;
  final Value<String> level;
  final Value<String> teacherLanguage;
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
    required String teacherLanguage,
    required String topic,
  }) : language = Value(language),
       level = Value(level),
       teacherLanguage = Value(teacherLanguage),
       topic = Value(topic);
  static Insertable<ChatDb> custom({
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
    Value<String>? teacherLanguage,
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

class $MessagesTable extends Messages
    with TableInfo<$MessagesTable, MessageDb> {
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
  static const VerificationMeta _caseTypeMeta = const VerificationMeta(
    'caseType',
  );
  @override
  late final GeneratedColumn<String> caseType = GeneratedColumn<String>(
    'case_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assistantMessageMeta = const VerificationMeta(
    'assistantMessage',
  );
  @override
  late final GeneratedColumn<String> assistantMessage = GeneratedColumn<String>(
    'assistant_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _correctionOriginalMeta =
      const VerificationMeta('correctionOriginal');
  @override
  late final GeneratedColumn<String> correctionOriginal =
      GeneratedColumn<String>(
        'correction_original',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _correctionCorrectedMarkdownMeta =
      const VerificationMeta('correctionCorrectedMarkdown');
  @override
  late final GeneratedColumn<String> correctionCorrectedMarkdown =
      GeneratedColumn<String>(
        'correction_corrected_markdown',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _correctionExplanationMeta =
      const VerificationMeta('correctionExplanation');
  @override
  late final GeneratedColumn<String> correctionExplanation =
      GeneratedColumn<String>(
        'correction_explanation',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _suggestedTranslationUserMeaningMeta =
      const VerificationMeta('suggestedTranslationUserMeaning');
  @override
  late final GeneratedColumn<String> suggestedTranslationUserMeaning =
      GeneratedColumn<String>(
        'suggested_translation_user_meaning',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _suggestedTranslationTranslationMeta =
      const VerificationMeta('suggestedTranslationTranslation');
  @override
  late final GeneratedColumn<String> suggestedTranslationTranslation =
      GeneratedColumn<String>(
        'suggested_translation_translation',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _userQuestionAnswerQuestionMeta =
      const VerificationMeta('userQuestionAnswerQuestion');
  @override
  late final GeneratedColumn<String> userQuestionAnswerQuestion =
      GeneratedColumn<String>(
        'user_question_answer_question',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _userQuestionAnswerAnswerMeta =
      const VerificationMeta('userQuestionAnswerAnswer');
  @override
  late final GeneratedColumn<String> userQuestionAnswerAnswer =
      GeneratedColumn<String>(
        'user_question_answer_answer',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _conversationContinueMeta =
      const VerificationMeta('conversationContinue');
  @override
  late final GeneratedColumn<String> conversationContinue =
      GeneratedColumn<String>(
        'conversation_continue',
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
    caseType,
    assistantMessage,
    correctionOriginal,
    correctionCorrectedMarkdown,
    correctionExplanation,
    suggestedTranslationUserMeaning,
    suggestedTranslationTranslation,
    userQuestionAnswerQuestion,
    userQuestionAnswerAnswer,
    conversationContinue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageDb> instance, {
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
    if (data.containsKey('case_type')) {
      context.handle(
        _caseTypeMeta,
        caseType.isAcceptableOrUnknown(data['case_type']!, _caseTypeMeta),
      );
    }
    if (data.containsKey('assistant_message')) {
      context.handle(
        _assistantMessageMeta,
        assistantMessage.isAcceptableOrUnknown(
          data['assistant_message']!,
          _assistantMessageMeta,
        ),
      );
    }
    if (data.containsKey('correction_original')) {
      context.handle(
        _correctionOriginalMeta,
        correctionOriginal.isAcceptableOrUnknown(
          data['correction_original']!,
          _correctionOriginalMeta,
        ),
      );
    }
    if (data.containsKey('correction_corrected_markdown')) {
      context.handle(
        _correctionCorrectedMarkdownMeta,
        correctionCorrectedMarkdown.isAcceptableOrUnknown(
          data['correction_corrected_markdown']!,
          _correctionCorrectedMarkdownMeta,
        ),
      );
    }
    if (data.containsKey('correction_explanation')) {
      context.handle(
        _correctionExplanationMeta,
        correctionExplanation.isAcceptableOrUnknown(
          data['correction_explanation']!,
          _correctionExplanationMeta,
        ),
      );
    }
    if (data.containsKey('suggested_translation_user_meaning')) {
      context.handle(
        _suggestedTranslationUserMeaningMeta,
        suggestedTranslationUserMeaning.isAcceptableOrUnknown(
          data['suggested_translation_user_meaning']!,
          _suggestedTranslationUserMeaningMeta,
        ),
      );
    }
    if (data.containsKey('suggested_translation_translation')) {
      context.handle(
        _suggestedTranslationTranslationMeta,
        suggestedTranslationTranslation.isAcceptableOrUnknown(
          data['suggested_translation_translation']!,
          _suggestedTranslationTranslationMeta,
        ),
      );
    }
    if (data.containsKey('user_question_answer_question')) {
      context.handle(
        _userQuestionAnswerQuestionMeta,
        userQuestionAnswerQuestion.isAcceptableOrUnknown(
          data['user_question_answer_question']!,
          _userQuestionAnswerQuestionMeta,
        ),
      );
    }
    if (data.containsKey('user_question_answer_answer')) {
      context.handle(
        _userQuestionAnswerAnswerMeta,
        userQuestionAnswerAnswer.isAcceptableOrUnknown(
          data['user_question_answer_answer']!,
          _userQuestionAnswerAnswerMeta,
        ),
      );
    }
    if (data.containsKey('conversation_continue')) {
      context.handle(
        _conversationContinueMeta,
        conversationContinue.isAcceptableOrUnknown(
          data['conversation_continue']!,
          _conversationContinueMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {messageId};
  @override
  MessageDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageDb(
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
      caseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}case_type'],
      ),
      assistantMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assistant_message'],
      ),
      correctionOriginal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correction_original'],
      ),
      correctionCorrectedMarkdown: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correction_corrected_markdown'],
      ),
      correctionExplanation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}correction_explanation'],
      ),
      suggestedTranslationUserMeaning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suggested_translation_user_meaning'],
      ),
      suggestedTranslationTranslation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}suggested_translation_translation'],
      ),
      userQuestionAnswerQuestion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_question_answer_question'],
      ),
      userQuestionAnswerAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_question_answer_answer'],
      ),
      conversationContinue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_continue'],
      ),
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class MessageDb extends DataClass implements Insertable<MessageDb> {
  final int messageId;
  final int chatId;
  final DateTime createdAt;
  final String message;
  final String? gptResponseId;
  final String? caseType;
  final String? assistantMessage;
  final String? correctionOriginal;
  final String? correctionCorrectedMarkdown;
  final String? correctionExplanation;
  final String? suggestedTranslationUserMeaning;
  final String? suggestedTranslationTranslation;
  final String? userQuestionAnswerQuestion;
  final String? userQuestionAnswerAnswer;
  final String? conversationContinue;
  const MessageDb({
    required this.messageId,
    required this.chatId,
    required this.createdAt,
    required this.message,
    this.gptResponseId,
    this.caseType,
    this.assistantMessage,
    this.correctionOriginal,
    this.correctionCorrectedMarkdown,
    this.correctionExplanation,
    this.suggestedTranslationUserMeaning,
    this.suggestedTranslationTranslation,
    this.userQuestionAnswerQuestion,
    this.userQuestionAnswerAnswer,
    this.conversationContinue,
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
    if (!nullToAbsent || caseType != null) {
      map['case_type'] = Variable<String>(caseType);
    }
    if (!nullToAbsent || assistantMessage != null) {
      map['assistant_message'] = Variable<String>(assistantMessage);
    }
    if (!nullToAbsent || correctionOriginal != null) {
      map['correction_original'] = Variable<String>(correctionOriginal);
    }
    if (!nullToAbsent || correctionCorrectedMarkdown != null) {
      map['correction_corrected_markdown'] = Variable<String>(
        correctionCorrectedMarkdown,
      );
    }
    if (!nullToAbsent || correctionExplanation != null) {
      map['correction_explanation'] = Variable<String>(correctionExplanation);
    }
    if (!nullToAbsent || suggestedTranslationUserMeaning != null) {
      map['suggested_translation_user_meaning'] = Variable<String>(
        suggestedTranslationUserMeaning,
      );
    }
    if (!nullToAbsent || suggestedTranslationTranslation != null) {
      map['suggested_translation_translation'] = Variable<String>(
        suggestedTranslationTranslation,
      );
    }
    if (!nullToAbsent || userQuestionAnswerQuestion != null) {
      map['user_question_answer_question'] = Variable<String>(
        userQuestionAnswerQuestion,
      );
    }
    if (!nullToAbsent || userQuestionAnswerAnswer != null) {
      map['user_question_answer_answer'] = Variable<String>(
        userQuestionAnswerAnswer,
      );
    }
    if (!nullToAbsent || conversationContinue != null) {
      map['conversation_continue'] = Variable<String>(conversationContinue);
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
      caseType: caseType == null && nullToAbsent
          ? const Value.absent()
          : Value(caseType),
      assistantMessage: assistantMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(assistantMessage),
      correctionOriginal: correctionOriginal == null && nullToAbsent
          ? const Value.absent()
          : Value(correctionOriginal),
      correctionCorrectedMarkdown:
          correctionCorrectedMarkdown == null && nullToAbsent
          ? const Value.absent()
          : Value(correctionCorrectedMarkdown),
      correctionExplanation: correctionExplanation == null && nullToAbsent
          ? const Value.absent()
          : Value(correctionExplanation),
      suggestedTranslationUserMeaning:
          suggestedTranslationUserMeaning == null && nullToAbsent
          ? const Value.absent()
          : Value(suggestedTranslationUserMeaning),
      suggestedTranslationTranslation:
          suggestedTranslationTranslation == null && nullToAbsent
          ? const Value.absent()
          : Value(suggestedTranslationTranslation),
      userQuestionAnswerQuestion:
          userQuestionAnswerQuestion == null && nullToAbsent
          ? const Value.absent()
          : Value(userQuestionAnswerQuestion),
      userQuestionAnswerAnswer: userQuestionAnswerAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(userQuestionAnswerAnswer),
      conversationContinue: conversationContinue == null && nullToAbsent
          ? const Value.absent()
          : Value(conversationContinue),
    );
  }

  factory MessageDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageDb(
      messageId: serializer.fromJson<int>(json['messageId']),
      chatId: serializer.fromJson<int>(json['chatId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      message: serializer.fromJson<String>(json['message']),
      gptResponseId: serializer.fromJson<String?>(json['gptResponseId']),
      caseType: serializer.fromJson<String?>(json['caseType']),
      assistantMessage: serializer.fromJson<String?>(json['assistantMessage']),
      correctionOriginal: serializer.fromJson<String?>(
        json['correctionOriginal'],
      ),
      correctionCorrectedMarkdown: serializer.fromJson<String?>(
        json['correctionCorrectedMarkdown'],
      ),
      correctionExplanation: serializer.fromJson<String?>(
        json['correctionExplanation'],
      ),
      suggestedTranslationUserMeaning: serializer.fromJson<String?>(
        json['suggestedTranslationUserMeaning'],
      ),
      suggestedTranslationTranslation: serializer.fromJson<String?>(
        json['suggestedTranslationTranslation'],
      ),
      userQuestionAnswerQuestion: serializer.fromJson<String?>(
        json['userQuestionAnswerQuestion'],
      ),
      userQuestionAnswerAnswer: serializer.fromJson<String?>(
        json['userQuestionAnswerAnswer'],
      ),
      conversationContinue: serializer.fromJson<String?>(
        json['conversationContinue'],
      ),
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
      'caseType': serializer.toJson<String?>(caseType),
      'assistantMessage': serializer.toJson<String?>(assistantMessage),
      'correctionOriginal': serializer.toJson<String?>(correctionOriginal),
      'correctionCorrectedMarkdown': serializer.toJson<String?>(
        correctionCorrectedMarkdown,
      ),
      'correctionExplanation': serializer.toJson<String?>(
        correctionExplanation,
      ),
      'suggestedTranslationUserMeaning': serializer.toJson<String?>(
        suggestedTranslationUserMeaning,
      ),
      'suggestedTranslationTranslation': serializer.toJson<String?>(
        suggestedTranslationTranslation,
      ),
      'userQuestionAnswerQuestion': serializer.toJson<String?>(
        userQuestionAnswerQuestion,
      ),
      'userQuestionAnswerAnswer': serializer.toJson<String?>(
        userQuestionAnswerAnswer,
      ),
      'conversationContinue': serializer.toJson<String?>(conversationContinue),
    };
  }

  MessageDb copyWith({
    int? messageId,
    int? chatId,
    DateTime? createdAt,
    String? message,
    Value<String?> gptResponseId = const Value.absent(),
    Value<String?> caseType = const Value.absent(),
    Value<String?> assistantMessage = const Value.absent(),
    Value<String?> correctionOriginal = const Value.absent(),
    Value<String?> correctionCorrectedMarkdown = const Value.absent(),
    Value<String?> correctionExplanation = const Value.absent(),
    Value<String?> suggestedTranslationUserMeaning = const Value.absent(),
    Value<String?> suggestedTranslationTranslation = const Value.absent(),
    Value<String?> userQuestionAnswerQuestion = const Value.absent(),
    Value<String?> userQuestionAnswerAnswer = const Value.absent(),
    Value<String?> conversationContinue = const Value.absent(),
  }) => MessageDb(
    messageId: messageId ?? this.messageId,
    chatId: chatId ?? this.chatId,
    createdAt: createdAt ?? this.createdAt,
    message: message ?? this.message,
    gptResponseId: gptResponseId.present
        ? gptResponseId.value
        : this.gptResponseId,
    caseType: caseType.present ? caseType.value : this.caseType,
    assistantMessage: assistantMessage.present
        ? assistantMessage.value
        : this.assistantMessage,
    correctionOriginal: correctionOriginal.present
        ? correctionOriginal.value
        : this.correctionOriginal,
    correctionCorrectedMarkdown: correctionCorrectedMarkdown.present
        ? correctionCorrectedMarkdown.value
        : this.correctionCorrectedMarkdown,
    correctionExplanation: correctionExplanation.present
        ? correctionExplanation.value
        : this.correctionExplanation,
    suggestedTranslationUserMeaning: suggestedTranslationUserMeaning.present
        ? suggestedTranslationUserMeaning.value
        : this.suggestedTranslationUserMeaning,
    suggestedTranslationTranslation: suggestedTranslationTranslation.present
        ? suggestedTranslationTranslation.value
        : this.suggestedTranslationTranslation,
    userQuestionAnswerQuestion: userQuestionAnswerQuestion.present
        ? userQuestionAnswerQuestion.value
        : this.userQuestionAnswerQuestion,
    userQuestionAnswerAnswer: userQuestionAnswerAnswer.present
        ? userQuestionAnswerAnswer.value
        : this.userQuestionAnswerAnswer,
    conversationContinue: conversationContinue.present
        ? conversationContinue.value
        : this.conversationContinue,
  );
  MessageDb copyWithCompanion(MessagesCompanion data) {
    return MessageDb(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      message: data.message.present ? data.message.value : this.message,
      gptResponseId: data.gptResponseId.present
          ? data.gptResponseId.value
          : this.gptResponseId,
      caseType: data.caseType.present ? data.caseType.value : this.caseType,
      assistantMessage: data.assistantMessage.present
          ? data.assistantMessage.value
          : this.assistantMessage,
      correctionOriginal: data.correctionOriginal.present
          ? data.correctionOriginal.value
          : this.correctionOriginal,
      correctionCorrectedMarkdown: data.correctionCorrectedMarkdown.present
          ? data.correctionCorrectedMarkdown.value
          : this.correctionCorrectedMarkdown,
      correctionExplanation: data.correctionExplanation.present
          ? data.correctionExplanation.value
          : this.correctionExplanation,
      suggestedTranslationUserMeaning:
          data.suggestedTranslationUserMeaning.present
          ? data.suggestedTranslationUserMeaning.value
          : this.suggestedTranslationUserMeaning,
      suggestedTranslationTranslation:
          data.suggestedTranslationTranslation.present
          ? data.suggestedTranslationTranslation.value
          : this.suggestedTranslationTranslation,
      userQuestionAnswerQuestion: data.userQuestionAnswerQuestion.present
          ? data.userQuestionAnswerQuestion.value
          : this.userQuestionAnswerQuestion,
      userQuestionAnswerAnswer: data.userQuestionAnswerAnswer.present
          ? data.userQuestionAnswerAnswer.value
          : this.userQuestionAnswerAnswer,
      conversationContinue: data.conversationContinue.present
          ? data.conversationContinue.value
          : this.conversationContinue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageDb(')
          ..write('messageId: $messageId, ')
          ..write('chatId: $chatId, ')
          ..write('createdAt: $createdAt, ')
          ..write('message: $message, ')
          ..write('gptResponseId: $gptResponseId, ')
          ..write('caseType: $caseType, ')
          ..write('assistantMessage: $assistantMessage, ')
          ..write('correctionOriginal: $correctionOriginal, ')
          ..write('correctionCorrectedMarkdown: $correctionCorrectedMarkdown, ')
          ..write('correctionExplanation: $correctionExplanation, ')
          ..write(
            'suggestedTranslationUserMeaning: $suggestedTranslationUserMeaning, ',
          )
          ..write(
            'suggestedTranslationTranslation: $suggestedTranslationTranslation, ',
          )
          ..write('userQuestionAnswerQuestion: $userQuestionAnswerQuestion, ')
          ..write('userQuestionAnswerAnswer: $userQuestionAnswerAnswer, ')
          ..write('conversationContinue: $conversationContinue')
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
    caseType,
    assistantMessage,
    correctionOriginal,
    correctionCorrectedMarkdown,
    correctionExplanation,
    suggestedTranslationUserMeaning,
    suggestedTranslationTranslation,
    userQuestionAnswerQuestion,
    userQuestionAnswerAnswer,
    conversationContinue,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageDb &&
          other.messageId == this.messageId &&
          other.chatId == this.chatId &&
          other.createdAt == this.createdAt &&
          other.message == this.message &&
          other.gptResponseId == this.gptResponseId &&
          other.caseType == this.caseType &&
          other.assistantMessage == this.assistantMessage &&
          other.correctionOriginal == this.correctionOriginal &&
          other.correctionCorrectedMarkdown ==
              this.correctionCorrectedMarkdown &&
          other.correctionExplanation == this.correctionExplanation &&
          other.suggestedTranslationUserMeaning ==
              this.suggestedTranslationUserMeaning &&
          other.suggestedTranslationTranslation ==
              this.suggestedTranslationTranslation &&
          other.userQuestionAnswerQuestion == this.userQuestionAnswerQuestion &&
          other.userQuestionAnswerAnswer == this.userQuestionAnswerAnswer &&
          other.conversationContinue == this.conversationContinue);
}

class MessagesCompanion extends UpdateCompanion<MessageDb> {
  final Value<int> messageId;
  final Value<int> chatId;
  final Value<DateTime> createdAt;
  final Value<String> message;
  final Value<String?> gptResponseId;
  final Value<String?> caseType;
  final Value<String?> assistantMessage;
  final Value<String?> correctionOriginal;
  final Value<String?> correctionCorrectedMarkdown;
  final Value<String?> correctionExplanation;
  final Value<String?> suggestedTranslationUserMeaning;
  final Value<String?> suggestedTranslationTranslation;
  final Value<String?> userQuestionAnswerQuestion;
  final Value<String?> userQuestionAnswerAnswer;
  final Value<String?> conversationContinue;
  const MessagesCompanion({
    this.messageId = const Value.absent(),
    this.chatId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.message = const Value.absent(),
    this.gptResponseId = const Value.absent(),
    this.caseType = const Value.absent(),
    this.assistantMessage = const Value.absent(),
    this.correctionOriginal = const Value.absent(),
    this.correctionCorrectedMarkdown = const Value.absent(),
    this.correctionExplanation = const Value.absent(),
    this.suggestedTranslationUserMeaning = const Value.absent(),
    this.suggestedTranslationTranslation = const Value.absent(),
    this.userQuestionAnswerQuestion = const Value.absent(),
    this.userQuestionAnswerAnswer = const Value.absent(),
    this.conversationContinue = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.messageId = const Value.absent(),
    required int chatId,
    this.createdAt = const Value.absent(),
    required String message,
    this.gptResponseId = const Value.absent(),
    this.caseType = const Value.absent(),
    this.assistantMessage = const Value.absent(),
    this.correctionOriginal = const Value.absent(),
    this.correctionCorrectedMarkdown = const Value.absent(),
    this.correctionExplanation = const Value.absent(),
    this.suggestedTranslationUserMeaning = const Value.absent(),
    this.suggestedTranslationTranslation = const Value.absent(),
    this.userQuestionAnswerQuestion = const Value.absent(),
    this.userQuestionAnswerAnswer = const Value.absent(),
    this.conversationContinue = const Value.absent(),
  }) : chatId = Value(chatId),
       message = Value(message);
  static Insertable<MessageDb> custom({
    Expression<int>? messageId,
    Expression<int>? chatId,
    Expression<DateTime>? createdAt,
    Expression<String>? message,
    Expression<String>? gptResponseId,
    Expression<String>? caseType,
    Expression<String>? assistantMessage,
    Expression<String>? correctionOriginal,
    Expression<String>? correctionCorrectedMarkdown,
    Expression<String>? correctionExplanation,
    Expression<String>? suggestedTranslationUserMeaning,
    Expression<String>? suggestedTranslationTranslation,
    Expression<String>? userQuestionAnswerQuestion,
    Expression<String>? userQuestionAnswerAnswer,
    Expression<String>? conversationContinue,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (chatId != null) 'chat_id': chatId,
      if (createdAt != null) 'created_at': createdAt,
      if (message != null) 'message': message,
      if (gptResponseId != null) 'gpt_response_id': gptResponseId,
      if (caseType != null) 'case_type': caseType,
      if (assistantMessage != null) 'assistant_message': assistantMessage,
      if (correctionOriginal != null) 'correction_original': correctionOriginal,
      if (correctionCorrectedMarkdown != null)
        'correction_corrected_markdown': correctionCorrectedMarkdown,
      if (correctionExplanation != null)
        'correction_explanation': correctionExplanation,
      if (suggestedTranslationUserMeaning != null)
        'suggested_translation_user_meaning': suggestedTranslationUserMeaning,
      if (suggestedTranslationTranslation != null)
        'suggested_translation_translation': suggestedTranslationTranslation,
      if (userQuestionAnswerQuestion != null)
        'user_question_answer_question': userQuestionAnswerQuestion,
      if (userQuestionAnswerAnswer != null)
        'user_question_answer_answer': userQuestionAnswerAnswer,
      if (conversationContinue != null)
        'conversation_continue': conversationContinue,
    });
  }

  MessagesCompanion copyWith({
    Value<int>? messageId,
    Value<int>? chatId,
    Value<DateTime>? createdAt,
    Value<String>? message,
    Value<String?>? gptResponseId,
    Value<String?>? caseType,
    Value<String?>? assistantMessage,
    Value<String?>? correctionOriginal,
    Value<String?>? correctionCorrectedMarkdown,
    Value<String?>? correctionExplanation,
    Value<String?>? suggestedTranslationUserMeaning,
    Value<String?>? suggestedTranslationTranslation,
    Value<String?>? userQuestionAnswerQuestion,
    Value<String?>? userQuestionAnswerAnswer,
    Value<String?>? conversationContinue,
  }) {
    return MessagesCompanion(
      messageId: messageId ?? this.messageId,
      chatId: chatId ?? this.chatId,
      createdAt: createdAt ?? this.createdAt,
      message: message ?? this.message,
      gptResponseId: gptResponseId ?? this.gptResponseId,
      caseType: caseType ?? this.caseType,
      assistantMessage: assistantMessage ?? this.assistantMessage,
      correctionOriginal: correctionOriginal ?? this.correctionOriginal,
      correctionCorrectedMarkdown:
          correctionCorrectedMarkdown ?? this.correctionCorrectedMarkdown,
      correctionExplanation:
          correctionExplanation ?? this.correctionExplanation,
      suggestedTranslationUserMeaning:
          suggestedTranslationUserMeaning ??
          this.suggestedTranslationUserMeaning,
      suggestedTranslationTranslation:
          suggestedTranslationTranslation ??
          this.suggestedTranslationTranslation,
      userQuestionAnswerQuestion:
          userQuestionAnswerQuestion ?? this.userQuestionAnswerQuestion,
      userQuestionAnswerAnswer:
          userQuestionAnswerAnswer ?? this.userQuestionAnswerAnswer,
      conversationContinue: conversationContinue ?? this.conversationContinue,
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
    if (caseType.present) {
      map['case_type'] = Variable<String>(caseType.value);
    }
    if (assistantMessage.present) {
      map['assistant_message'] = Variable<String>(assistantMessage.value);
    }
    if (correctionOriginal.present) {
      map['correction_original'] = Variable<String>(correctionOriginal.value);
    }
    if (correctionCorrectedMarkdown.present) {
      map['correction_corrected_markdown'] = Variable<String>(
        correctionCorrectedMarkdown.value,
      );
    }
    if (correctionExplanation.present) {
      map['correction_explanation'] = Variable<String>(
        correctionExplanation.value,
      );
    }
    if (suggestedTranslationUserMeaning.present) {
      map['suggested_translation_user_meaning'] = Variable<String>(
        suggestedTranslationUserMeaning.value,
      );
    }
    if (suggestedTranslationTranslation.present) {
      map['suggested_translation_translation'] = Variable<String>(
        suggestedTranslationTranslation.value,
      );
    }
    if (userQuestionAnswerQuestion.present) {
      map['user_question_answer_question'] = Variable<String>(
        userQuestionAnswerQuestion.value,
      );
    }
    if (userQuestionAnswerAnswer.present) {
      map['user_question_answer_answer'] = Variable<String>(
        userQuestionAnswerAnswer.value,
      );
    }
    if (conversationContinue.present) {
      map['conversation_continue'] = Variable<String>(
        conversationContinue.value,
      );
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
          ..write('caseType: $caseType, ')
          ..write('assistantMessage: $assistantMessage, ')
          ..write('correctionOriginal: $correctionOriginal, ')
          ..write('correctionCorrectedMarkdown: $correctionCorrectedMarkdown, ')
          ..write('correctionExplanation: $correctionExplanation, ')
          ..write(
            'suggestedTranslationUserMeaning: $suggestedTranslationUserMeaning, ',
          )
          ..write(
            'suggestedTranslationTranslation: $suggestedTranslationTranslation, ',
          )
          ..write('userQuestionAnswerQuestion: $userQuestionAnswerQuestion, ')
          ..write('userQuestionAnswerAnswer: $userQuestionAnswerAnswer, ')
          ..write('conversationContinue: $conversationContinue')
          ..write(')'))
        .toString();
  }
}

class $SessionsDurationsTable extends SessionsDurations
    with TableInfo<$SessionsDurationsTable, SessionDurationDb> {
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
    Insertable<SessionDurationDb> instance, {
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
  SessionDurationDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionDurationDb(
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

class SessionDurationDb extends DataClass
    implements Insertable<SessionDurationDb> {
  final int sessionId;
  final DateTime createdAt;
  final int durationInMilliseconds;
  const SessionDurationDb({
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

  factory SessionDurationDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionDurationDb(
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

  SessionDurationDb copyWith({
    int? sessionId,
    DateTime? createdAt,
    int? durationInMilliseconds,
  }) => SessionDurationDb(
    sessionId: sessionId ?? this.sessionId,
    createdAt: createdAt ?? this.createdAt,
    durationInMilliseconds:
        durationInMilliseconds ?? this.durationInMilliseconds,
  );
  SessionDurationDb copyWithCompanion(SessionsDurationsCompanion data) {
    return SessionDurationDb(
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      durationInMilliseconds: data.durationInMilliseconds.present
          ? data.durationInMilliseconds.value
          : this.durationInMilliseconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionDurationDb(')
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
      (other is SessionDurationDb &&
          other.sessionId == this.sessionId &&
          other.createdAt == this.createdAt &&
          other.durationInMilliseconds == this.durationInMilliseconds);
}

class SessionsDurationsCompanion extends UpdateCompanion<SessionDurationDb> {
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
  static Insertable<SessionDurationDb> custom({
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

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingDb> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingDb> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingDb map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingDb(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingDb extends DataClass implements Insertable<SettingDb> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const SettingDb({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingDb.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingDb(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SettingDb copyWith({String? key, String? value, DateTime? updatedAt}) =>
      SettingDb(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SettingDb copyWithCompanion(SettingsCompanion data) {
    return SettingDb(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingDb(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingDb &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SettingsCompanion extends UpdateCompanion<SettingDb> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingDb> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
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
  late final $SessionsDurationsTable sessionsDurations =
      $SessionsDurationsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final ChatDao chatDao = ChatDao(this as AppDatabase);
  late final MessageDao messageDao = MessageDao(this as AppDatabase);
  late final SessionsDurationsDao sessionsDurationsDao = SessionsDurationsDao(
    this as AppDatabase,
  );
  late final SettingsDao settingsDao = SettingsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    chats,
    messages,
    sessionsDurations,
    settings,
  ];
}

typedef $$ChatsTableCreateCompanionBuilder =
    ChatsCompanion Function({
      Value<int> chatId,
      Value<DateTime> createdAt,
      required String language,
      required String level,
      required String teacherLanguage,
      required String topic,
    });
typedef $$ChatsTableUpdateCompanionBuilder =
    ChatsCompanion Function({
      Value<int> chatId,
      Value<DateTime> createdAt,
      Value<String> language,
      Value<String> level,
      Value<String> teacherLanguage,
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
          ChatDb,
          $$ChatsTableFilterComposer,
          $$ChatsTableOrderingComposer,
          $$ChatsTableAnnotationComposer,
          $$ChatsTableCreateCompanionBuilder,
          $$ChatsTableUpdateCompanionBuilder,
          (ChatDb, BaseReferences<_$AppDatabase, $ChatsTable, ChatDb>),
          ChatDb,
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
                Value<String> teacherLanguage = const Value.absent(),
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
                required String teacherLanguage,
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
      ChatDb,
      $$ChatsTableFilterComposer,
      $$ChatsTableOrderingComposer,
      $$ChatsTableAnnotationComposer,
      $$ChatsTableCreateCompanionBuilder,
      $$ChatsTableUpdateCompanionBuilder,
      (ChatDb, BaseReferences<_$AppDatabase, $ChatsTable, ChatDb>),
      ChatDb,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> messageId,
      required int chatId,
      Value<DateTime> createdAt,
      required String message,
      Value<String?> gptResponseId,
      Value<String?> caseType,
      Value<String?> assistantMessage,
      Value<String?> correctionOriginal,
      Value<String?> correctionCorrectedMarkdown,
      Value<String?> correctionExplanation,
      Value<String?> suggestedTranslationUserMeaning,
      Value<String?> suggestedTranslationTranslation,
      Value<String?> userQuestionAnswerQuestion,
      Value<String?> userQuestionAnswerAnswer,
      Value<String?> conversationContinue,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<int> messageId,
      Value<int> chatId,
      Value<DateTime> createdAt,
      Value<String> message,
      Value<String?> gptResponseId,
      Value<String?> caseType,
      Value<String?> assistantMessage,
      Value<String?> correctionOriginal,
      Value<String?> correctionCorrectedMarkdown,
      Value<String?> correctionExplanation,
      Value<String?> suggestedTranslationUserMeaning,
      Value<String?> suggestedTranslationTranslation,
      Value<String?> userQuestionAnswerQuestion,
      Value<String?> userQuestionAnswerAnswer,
      Value<String?> conversationContinue,
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

  ColumnFilters<String> get caseType => $composableBuilder(
    column: $table.caseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assistantMessage => $composableBuilder(
    column: $table.assistantMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correctionOriginal => $composableBuilder(
    column: $table.correctionOriginal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correctionCorrectedMarkdown => $composableBuilder(
    column: $table.correctionCorrectedMarkdown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get correctionExplanation => $composableBuilder(
    column: $table.correctionExplanation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get suggestedTranslationUserMeaning =>
      $composableBuilder(
        column: $table.suggestedTranslationUserMeaning,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get suggestedTranslationTranslation =>
      $composableBuilder(
        column: $table.suggestedTranslationTranslation,
        builder: (column) => ColumnFilters(column),
      );

  ColumnFilters<String> get userQuestionAnswerQuestion => $composableBuilder(
    column: $table.userQuestionAnswerQuestion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userQuestionAnswerAnswer => $composableBuilder(
    column: $table.userQuestionAnswerAnswer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conversationContinue => $composableBuilder(
    column: $table.conversationContinue,
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

  ColumnOrderings<String> get caseType => $composableBuilder(
    column: $table.caseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assistantMessage => $composableBuilder(
    column: $table.assistantMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correctionOriginal => $composableBuilder(
    column: $table.correctionOriginal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correctionCorrectedMarkdown => $composableBuilder(
    column: $table.correctionCorrectedMarkdown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get correctionExplanation => $composableBuilder(
    column: $table.correctionExplanation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get suggestedTranslationUserMeaning =>
      $composableBuilder(
        column: $table.suggestedTranslationUserMeaning,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get suggestedTranslationTranslation =>
      $composableBuilder(
        column: $table.suggestedTranslationTranslation,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get userQuestionAnswerQuestion => $composableBuilder(
    column: $table.userQuestionAnswerQuestion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userQuestionAnswerAnswer => $composableBuilder(
    column: $table.userQuestionAnswerAnswer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conversationContinue => $composableBuilder(
    column: $table.conversationContinue,
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

  GeneratedColumn<String> get caseType =>
      $composableBuilder(column: $table.caseType, builder: (column) => column);

  GeneratedColumn<String> get assistantMessage => $composableBuilder(
    column: $table.assistantMessage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get correctionOriginal => $composableBuilder(
    column: $table.correctionOriginal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get correctionCorrectedMarkdown => $composableBuilder(
    column: $table.correctionCorrectedMarkdown,
    builder: (column) => column,
  );

  GeneratedColumn<String> get correctionExplanation => $composableBuilder(
    column: $table.correctionExplanation,
    builder: (column) => column,
  );

  GeneratedColumn<String> get suggestedTranslationUserMeaning =>
      $composableBuilder(
        column: $table.suggestedTranslationUserMeaning,
        builder: (column) => column,
      );

  GeneratedColumn<String> get suggestedTranslationTranslation =>
      $composableBuilder(
        column: $table.suggestedTranslationTranslation,
        builder: (column) => column,
      );

  GeneratedColumn<String> get userQuestionAnswerQuestion => $composableBuilder(
    column: $table.userQuestionAnswerQuestion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userQuestionAnswerAnswer => $composableBuilder(
    column: $table.userQuestionAnswerAnswer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conversationContinue => $composableBuilder(
    column: $table.conversationContinue,
    builder: (column) => column,
  );
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          MessageDb,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (MessageDb, BaseReferences<_$AppDatabase, $MessagesTable, MessageDb>),
          MessageDb,
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
                Value<String?> caseType = const Value.absent(),
                Value<String?> assistantMessage = const Value.absent(),
                Value<String?> correctionOriginal = const Value.absent(),
                Value<String?> correctionCorrectedMarkdown =
                    const Value.absent(),
                Value<String?> correctionExplanation = const Value.absent(),
                Value<String?> suggestedTranslationUserMeaning =
                    const Value.absent(),
                Value<String?> suggestedTranslationTranslation =
                    const Value.absent(),
                Value<String?> userQuestionAnswerQuestion =
                    const Value.absent(),
                Value<String?> userQuestionAnswerAnswer = const Value.absent(),
                Value<String?> conversationContinue = const Value.absent(),
              }) => MessagesCompanion(
                messageId: messageId,
                chatId: chatId,
                createdAt: createdAt,
                message: message,
                gptResponseId: gptResponseId,
                caseType: caseType,
                assistantMessage: assistantMessage,
                correctionOriginal: correctionOriginal,
                correctionCorrectedMarkdown: correctionCorrectedMarkdown,
                correctionExplanation: correctionExplanation,
                suggestedTranslationUserMeaning:
                    suggestedTranslationUserMeaning,
                suggestedTranslationTranslation:
                    suggestedTranslationTranslation,
                userQuestionAnswerQuestion: userQuestionAnswerQuestion,
                userQuestionAnswerAnswer: userQuestionAnswerAnswer,
                conversationContinue: conversationContinue,
              ),
          createCompanionCallback:
              ({
                Value<int> messageId = const Value.absent(),
                required int chatId,
                Value<DateTime> createdAt = const Value.absent(),
                required String message,
                Value<String?> gptResponseId = const Value.absent(),
                Value<String?> caseType = const Value.absent(),
                Value<String?> assistantMessage = const Value.absent(),
                Value<String?> correctionOriginal = const Value.absent(),
                Value<String?> correctionCorrectedMarkdown =
                    const Value.absent(),
                Value<String?> correctionExplanation = const Value.absent(),
                Value<String?> suggestedTranslationUserMeaning =
                    const Value.absent(),
                Value<String?> suggestedTranslationTranslation =
                    const Value.absent(),
                Value<String?> userQuestionAnswerQuestion =
                    const Value.absent(),
                Value<String?> userQuestionAnswerAnswer = const Value.absent(),
                Value<String?> conversationContinue = const Value.absent(),
              }) => MessagesCompanion.insert(
                messageId: messageId,
                chatId: chatId,
                createdAt: createdAt,
                message: message,
                gptResponseId: gptResponseId,
                caseType: caseType,
                assistantMessage: assistantMessage,
                correctionOriginal: correctionOriginal,
                correctionCorrectedMarkdown: correctionCorrectedMarkdown,
                correctionExplanation: correctionExplanation,
                suggestedTranslationUserMeaning:
                    suggestedTranslationUserMeaning,
                suggestedTranslationTranslation:
                    suggestedTranslationTranslation,
                userQuestionAnswerQuestion: userQuestionAnswerQuestion,
                userQuestionAnswerAnswer: userQuestionAnswerAnswer,
                conversationContinue: conversationContinue,
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
      MessageDb,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (MessageDb, BaseReferences<_$AppDatabase, $MessagesTable, MessageDb>),
      MessageDb,
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
          SessionDurationDb,
          $$SessionsDurationsTableFilterComposer,
          $$SessionsDurationsTableOrderingComposer,
          $$SessionsDurationsTableAnnotationComposer,
          $$SessionsDurationsTableCreateCompanionBuilder,
          $$SessionsDurationsTableUpdateCompanionBuilder,
          (
            SessionDurationDb,
            BaseReferences<
              _$AppDatabase,
              $SessionsDurationsTable,
              SessionDurationDb
            >,
          ),
          SessionDurationDb,
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
      SessionDurationDb,
      $$SessionsDurationsTableFilterComposer,
      $$SessionsDurationsTableOrderingComposer,
      $$SessionsDurationsTableAnnotationComposer,
      $$SessionsDurationsTableCreateCompanionBuilder,
      $$SessionsDurationsTableUpdateCompanionBuilder,
      (
        SessionDurationDb,
        BaseReferences<
          _$AppDatabase,
          $SessionsDurationsTable,
          SessionDurationDb
        >,
      ),
      SessionDurationDb,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      required String key,
      required String value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          SettingDb,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (SettingDb, BaseReferences<_$AppDatabase, $SettingsTable, SettingDb>),
          SettingDb,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      SettingDb,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (SettingDb, BaseReferences<_$AppDatabase, $SettingsTable, SettingDb>),
      SettingDb,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ChatsTableTableManager get chats =>
      $$ChatsTableTableManager(_db, _db.chats);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$SessionsDurationsTableTableManager get sessionsDurations =>
      $$SessionsDurationsTableTableManager(_db, _db.sessionsDurations);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
