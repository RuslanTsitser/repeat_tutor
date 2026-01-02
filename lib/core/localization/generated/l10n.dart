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

  /// `Start`
  String get start {
    return Intl.message('Start', name: 'start', desc: '', args: []);
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

  /// `Enter a topic for your chat`
  String get enterATopicForYourChat {
    return Intl.message(
      'Enter a topic for your chat',
      name: 'enterATopicForYourChat',
      desc: '',
      args: [],
    );
  }

  /// `Or choose from examples below`
  String get orChooseFromExamples {
    return Intl.message(
      'Or choose from examples below',
      name: 'orChooseFromExamples',
      desc: '',
      args: [],
    );
  }

  /// `Select the language you want to learn`
  String get selectLanguageToLearn {
    return Intl.message(
      'Select the language you want to learn',
      name: 'selectLanguageToLearn',
      desc: '',
      args: [],
    );
  }

  /// `Choose your proficiency level`
  String get selectYourLevel {
    return Intl.message(
      'Choose your proficiency level',
      name: 'selectYourLevel',
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

  /// `• Practice without judgment\n• Make mistakes\n• Learn and grow`
  String get practiceWithoutJudgmentMakeMistakesLearnAndGrowInA {
    return Intl.message(
      '• Practice without judgment\n• Make mistakes\n• Learn and grow',
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

  /// `• Listen\n• Speak\n• Get feedback\n• Repeat`
  String get listenSpeakGetGentleAiFeedbackAndRepeatItsThe {
    return Intl.message(
      '• Listen\n• Speak\n• Get feedback\n• Repeat',
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

  /// `• From hesitation to confidence\n• Progress with every session\n• Natural speech`
  String get transformFromHesitantToNaturalSpeakerFeelTheProgressWith {
    return Intl.message(
      '• From hesitation to confidence\n• Progress with every session\n• Natural speech',
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

  /// `Week`
  String get week {
    return Intl.message('Week', name: 'week', desc: '', args: []);
  }

  /// `Month`
  String get month {
    return Intl.message('Month', name: 'month', desc: '', args: []);
  }

  /// `Year`
  String get year {
    return Intl.message('Year', name: 'year', desc: '', args: []);
  }

  /// `Period`
  String get period {
    return Intl.message('Period', name: 'period', desc: '', args: []);
  }

  /// `Weekly`
  String get weekly {
    return Intl.message('Weekly', name: 'weekly', desc: '', args: []);
  }

  /// `Monthly`
  String get monthly {
    return Intl.message('Monthly', name: 'monthly', desc: '', args: []);
  }

  /// `Yearly`
  String get yearly {
    return Intl.message('Yearly', name: 'yearly', desc: '', args: []);
  }

  /// `Upgrade to Premium`
  String get upgradeToPremium {
    return Intl.message(
      'Upgrade to Premium',
      name: 'upgradeToPremium',
      desc: '',
      args: [],
    );
  }

  /// `Get unlimited access to all features`
  String get getUnlimitedAccessToAllFeatures {
    return Intl.message(
      'Get unlimited access to all features',
      name: 'getUnlimitedAccessToAllFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited conversations`
  String get unlimitedConversations {
    return Intl.message(
      'Unlimited conversations',
      name: 'unlimitedConversations',
      desc: '',
      args: [],
    );
  }

  /// `Voice practice`
  String get voicePractice {
    return Intl.message(
      'Voice practice',
      name: 'voicePractice',
      desc: '',
      args: [],
    );
  }

  /// `Smart corrections`
  String get smartCorrections {
    return Intl.message(
      'Smart corrections',
      name: 'smartCorrections',
      desc: '',
      args: [],
    );
  }

  /// `Select plan`
  String get selectPlan {
    return Intl.message('Select plan', name: 'selectPlan', desc: '', args: []);
  }

  /// `Subscribe for`
  String get subscribeFor {
    return Intl.message(
      'Subscribe for',
      name: 'subscribeFor',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Premium`
  String get unlockPremium {
    return Intl.message(
      'Unlock Premium',
      name: 'unlockPremium',
      desc: '',
      args: [],
    );
  }

  /// `Practice speaking with confidence`
  String get practiceSpeakingWithConfidence {
    return Intl.message(
      'Practice speaking with confidence',
      name: 'practiceSpeakingWithConfidence',
      desc: '',
      args: [],
    );
  }

  /// `Voice practice mode`
  String get voicePracticeMode {
    return Intl.message(
      'Voice practice mode',
      name: 'voicePracticeMode',
      desc: '',
      args: [],
    );
  }

  /// `Advanced corrections`
  String get advancedCorrections {
    return Intl.message(
      'Advanced corrections',
      name: 'advancedCorrections',
      desc: '',
      args: [],
    );
  }

  /// `Priority support`
  String get prioritySupport {
    return Intl.message(
      'Priority support',
      name: 'prioritySupport',
      desc: '',
      args: [],
    );
  }

  /// `Choose your plan`
  String get chooseYourPlan {
    return Intl.message(
      'Choose your plan',
      name: 'chooseYourPlan',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Go Premium`
  String get goPremium {
    return Intl.message('Go Premium', name: 'goPremium', desc: '', args: []);
  }

  /// `Unlock all features and practice without limits`
  String get unlockAllFeaturesAndPracticeWithoutLimits {
    return Intl.message(
      'Unlock all features and practice without limits',
      name: 'unlockAllFeaturesAndPracticeWithoutLimits',
      desc: '',
      args: [],
    );
  }

  /// `per`
  String get per {
    return Intl.message('per', name: 'per', desc: '', args: []);
  }

  /// `What's included`
  String get whatsIncluded {
    return Intl.message(
      'What\'s included',
      name: 'whatsIncluded',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited chats`
  String get unlimitedChats {
    return Intl.message(
      'Unlimited chats',
      name: 'unlimitedChats',
      desc: '',
      args: [],
    );
  }

  /// `Voice mode`
  String get voiceMode {
    return Intl.message('Voice mode', name: 'voiceMode', desc: '', args: []);
  }

  /// `Start Premium`
  String get startPremium {
    return Intl.message(
      'Start Premium',
      name: 'startPremium',
      desc: '',
      args: [],
    );
  }

  /// `Premium Experience`
  String get premiumExperience {
    return Intl.message(
      'Premium Experience',
      name: 'premiumExperience',
      desc: '',
      args: [],
    );
  }

  /// `Everything you need to master a new language`
  String get everythingYouNeedToMasterANewLanguage {
    return Intl.message(
      'Everything you need to master a new language',
      name: 'everythingYouNeedToMasterANewLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Advanced voice practice`
  String get advancedVoicePractice {
    return Intl.message(
      'Advanced voice practice',
      name: 'advancedVoicePractice',
      desc: '',
      args: [],
    );
  }

  /// `Personalized feedback`
  String get personalizedFeedback {
    return Intl.message(
      'Personalized feedback',
      name: 'personalizedFeedback',
      desc: '',
      args: [],
    );
  }

  /// `24/7 AI tutor access`
  String get aiTutorAccess {
    return Intl.message(
      '24/7 AI tutor access',
      name: 'aiTutorAccess',
      desc: '',
      args: [],
    );
  }

  /// `Get Premium`
  String get getPremium {
    return Intl.message('Get Premium', name: 'getPremium', desc: '', args: []);
  }

  /// `Cancel anytime`
  String get cancelAnytime {
    return Intl.message(
      'Cancel anytime',
      name: 'cancelAnytime',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Listen`
  String get listen {
    return Intl.message('Listen', name: 'listen', desc: '', args: []);
  }

  /// `Speak`
  String get speak {
    return Intl.message('Speak', name: 'speak', desc: '', args: []);
  }

  /// `Learn`
  String get learn {
    return Intl.message('Learn', name: 'learn', desc: '', args: []);
  }

  /// `Repeat`
  String get repeat {
    return Intl.message('Repeat', name: 'repeat', desc: '', args: []);
  }

  /// `Configure the app interface language`
  String get configureAppLanguage {
    return Intl.message(
      'Configure the app interface language',
      name: 'configureAppLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select the language you want to learn`
  String get configureLanguageToLearn {
    return Intl.message(
      'Select the language you want to learn',
      name: 'configureLanguageToLearn',
      desc: '',
      args: [],
    );
  }

  /// `Select the language the tutor will speak`
  String get configureTutorLanguage {
    return Intl.message(
      'Select the language the tutor will speak',
      name: 'configureTutorLanguage',
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
