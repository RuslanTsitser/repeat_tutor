// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Voice call in progress`
  String get voiceCallInProgress {
    return Intl.message(
      'Voice call in progress',
      name: 'voiceCallInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Connected`
  String get connected {
    return Intl.message('Connected', name: 'connected', desc: '', args: []);
  }

  /// `Disconnected`
  String get disconnected {
    return Intl.message(
      'Disconnected',
      name: 'disconnected',
      desc: '',
      args: [],
    );
  }

  /// `Error loading chats`
  String get errorLoadingChats {
    return Intl.message(
      'Error loading chats',
      name: 'errorLoadingChats',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `No chats yet`
  String get noChatsYet {
    return Intl.message('No chats yet', name: 'noChatsYet', desc: '', args: []);
  }

  /// `Start your first conversation and begin practicing a new language`
  String get startYourFirstConversationAndBeginPracticingANewLanguage {
    return Intl.message(
      'Start your first conversation and begin practicing a new language',
      name: 'startYourFirstConversationAndBeginPracticingANewLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Start your first chat`
  String get startYourFirstChat {
    return Intl.message(
      'Start your first chat',
      name: 'startYourFirstChat',
      desc: '',
      args: [],
    );
  }

  /// `No messages`
  String get noMessages {
    return Intl.message('No messages', name: 'noMessages', desc: '', args: []);
  }

  /// `Type your message...`
  String get typeYourMessage {
    return Intl.message(
      'Type your message...',
      name: 'typeYourMessage',
      desc: '',
      args: [],
    );
  }

  /// `New chat`
  String get newChat {
    return Intl.message('New chat', name: 'newChat', desc: '', args: []);
  }

  /// `Topic`
  String get topic {
    return Intl.message('Topic', name: 'topic', desc: '', args: []);
  }

  /// `Language to learn`
  String get languageToLearn {
    return Intl.message(
      'Language to learn',
      name: 'languageToLearn',
      desc: '',
      args: [],
    );
  }

  /// `Teacher language`
  String get teacherLanguage {
    return Intl.message(
      'Teacher language',
      name: 'teacherLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get level {
    return Intl.message('Level', name: 'level', desc: '', args: []);
  }

  /// `e.g. Free time, Shopping, Travel`
  String get egFreeTimeShoppingTravel {
    return Intl.message(
      'e.g. Free time, Shopping, Travel',
      name: 'egFreeTimeShoppingTravel',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Chats`
  String get chats {
    return Intl.message('Chats', name: 'chats', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Free time`
  String get exampleTopicFreeTime {
    return Intl.message(
      'Free time',
      name: 'exampleTopicFreeTime',
      desc: '',
      args: [],
    );
  }

  /// `Shopping`
  String get exampleTopicShopping {
    return Intl.message(
      'Shopping',
      name: 'exampleTopicShopping',
      desc: '',
      args: [],
    );
  }

  /// `Travel`
  String get exampleTopicTravel {
    return Intl.message(
      'Travel',
      name: 'exampleTopicTravel',
      desc: '',
      args: [],
    );
  }

  /// `Food`
  String get exampleTopicFood {
    return Intl.message('Food', name: 'exampleTopicFood', desc: '', args: []);
  }

  /// `Work`
  String get exampleTopicWork {
    return Intl.message('Work', name: 'exampleTopicWork', desc: '', args: []);
  }

  /// `Hobbies`
  String get exampleTopicHobbies {
    return Intl.message(
      'Hobbies',
      name: 'exampleTopicHobbies',
      desc: '',
      args: [],
    );
  }

  /// `Sports`
  String get exampleTopicSports {
    return Intl.message(
      'Sports',
      name: 'exampleTopicSports',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Tutor language`
  String get tutorLanguage {
    return Intl.message(
      'Tutor language',
      name: 'tutorLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Call Duration`
  String get callDuration {
    return Intl.message(
      'Call Duration',
      name: 'callDuration',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `App language`
  String get appLanguage {
    return Intl.message(
      'App language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Hello!`
  String get hello {
    return Intl.message('Hello!', name: 'hello', desc: '', args: []);
  }

  /// `Start here`
  String get startHere {
    return Intl.message('Start here', name: 'startHere', desc: '', args: []);
  }

  /// `Tap to create a new chat`
  String get tapToCreateANewChat {
    return Intl.message(
      'Tap to create a new chat',
      name: 'tapToCreateANewChat',
      desc: '',
      args: [],
    );
  }

  /// `Tap to write a text message`
  String get tapToWriteATextMessage {
    return Intl.message(
      'Tap to write a text message',
      name: 'tapToWriteATextMessage',
      desc: '',
      args: [],
    );
  }

  /// `You can also practice speaking with a voice call`
  String get youCanAlsoPracticeSpeakingWithAVoiceCall {
    return Intl.message(
      'You can also practice speaking with a voice call',
      name: 'youCanAlsoPracticeSpeakingWithAVoiceCall',
      desc: '',
      args: [],
    );
  }

  /// `Or send an audio message`
  String get orSendAnAudioMessage {
    return Intl.message(
      'Or send an audio message',
      name: 'orSendAnAudioMessage',
      desc: '',
      args: [],
    );
  }

  /// `Safe Space`
  String get safeSpace {
    return Intl.message('Safe Space', name: 'safeSpace', desc: '', args: []);
  }

  /// `Scared to speak?`
  String get scaredToSpeak {
    return Intl.message(
      'Scared to speak?',
      name: 'scaredToSpeak',
      desc: '',
      args: [],
    );
  }

  /// `That's totally normal.`
  String get thatsTotallyNormal {
    return Intl.message(
      'That\'s totally normal.',
      name: 'thatsTotallyNormal',
      desc: '',
      args: [],
    );
  }

  /// `Practice without judgment. Make mistakes, learn, and grow in a private space designed for you.`
  String get practiceWithoutJudgmentMakeMistakesLearnAndGrowInA {
    return Intl.message(
      'Practice without judgment. Make mistakes, learn, and grow in a private space designed for you.',
      name: 'practiceWithoutJudgmentMakeMistakesLearnAndGrowInA',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueButton {
    return Intl.message('Continue', name: 'continueButton', desc: '', args: []);
  }

  /// `The Repetition Loop`
  String get theRepetitionLoop {
    return Intl.message(
      'The Repetition Loop',
      name: 'theRepetitionLoop',
      desc: '',
      args: [],
    );
  }

  /// `Listen, speak, get gentle AI feedback, and repeat. It's the natural way to fluency.`
  String get listenSpeakGetGentleAiFeedbackAndRepeatItsThe {
    return Intl.message(
      'Listen, speak, get gentle AI feedback, and repeat. It\'s the natural way to fluency.',
      name: 'listenSpeakGetGentleAiFeedbackAndRepeatItsThe',
      desc: '',
      args: [],
    );
  }

  /// `Personalized`
  String get personalized {
    return Intl.message(
      'Personalized',
      name: 'personalized',
      desc: '',
      args: [],
    );
  }

  /// `Pressure-free`
  String get pressureFree {
    return Intl.message(
      'Pressure-free',
      name: 'pressureFree',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get nextButton {
    return Intl.message('Next', name: 'nextButton', desc: '', args: []);
  }

  /// `Gain Real Confidence`
  String get gainRealConfidence {
    return Intl.message(
      'Gain Real Confidence',
      name: 'gainRealConfidence',
      desc: '',
      args: [],
    );
  }

  /// `Transform from hesitant to natural speaker. Feel the progress with every session.`
  String get transformFromHesitantToNaturalSpeakerFeelTheProgressWith {
    return Intl.message(
      'Transform from hesitant to natural speaker. Feel the progress with every session.',
      name: 'transformFromHesitantToNaturalSpeakerFeelTheProgressWith',
      desc: '',
      args: [],
    );
  }

  /// `Start Your Journey`
  String get startYourJourney {
    return Intl.message(
      'Start Your Journey',
      name: 'startYourJourney',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'PT'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
