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

  /// `Save`
  String get saveButton {
    return Intl.message('Save', name: 'saveButton', desc: '', args: []);
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

  /// `Welcome to Repeat Tutor`
  String get onboarding6WelcomeTitle {
    return Intl.message(
      'Welcome to Repeat Tutor',
      name: 'onboarding6WelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `A safe, stress-free place to practice speaking for real life`
  String get onboarding6WelcomeSubtitle {
    return Intl.message(
      'A safe, stress-free place to practice speaking for real life',
      name: 'onboarding6WelcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Practice the topics that matter in real life`
  String get onboarding6RealLifeTopicsTitle {
    return Intl.message(
      'Practice the topics that matter in real life',
      name: 'onboarding6RealLifeTopicsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Pick a topic and answer simple questions`
  String get onboarding6RealLifeTopicsSubtitle {
    return Intl.message(
      'Pick a topic and answer simple questions',
      name: 'onboarding6RealLifeTopicsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Make as many mistakes as you need`
  String get onboarding6MistakesOkTitle {
    return Intl.message(
      'Make as many mistakes as you need',
      name: 'onboarding6MistakesOkTitle',
      desc: '',
      args: [],
    );
  }

  /// `Speak your way — your teacher gently corrects you and makes your speech more natural, at your current level.`
  String get onboarding6MistakesOkSubtitle {
    return Intl.message(
      'Speak your way — your teacher gently corrects you and makes your speech more natural, at your current level.',
      name: 'onboarding6MistakesOkSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `I goed to the store yesterday`
  String get onboarding6MistakesOkExampleUserMessage {
    return Intl.message(
      'I goed to the store yesterday',
      name: 'onboarding6MistakesOkExampleUserMessage',
      desc: '',
      args: [],
    );
  }

  /// `Good! Here's a small correction:`
  String get onboarding6MistakesOkExampleTutorMessage {
    return Intl.message(
      'Good! Here\'s a small correction:',
      name: 'onboarding6MistakesOkExampleTutorMessage',
      desc: '',
      args: [],
    );
  }

  /// `The past tense of "go" is "went", not "goed".`
  String get onboarding6MistakesOkExampleExplanation {
    return Intl.message(
      'The past tense of "go" is "went", not "goed".',
      name: 'onboarding6MistakesOkExampleExplanation',
      desc: '',
      args: [],
    );
  }

  /// `What did you buy there?`
  String get onboarding6MistakesOkExampleContinue {
    return Intl.message(
      'What did you buy there?',
      name: 'onboarding6MistakesOkExampleContinue',
      desc: '',
      args: [],
    );
  }

  /// `Fun fact: Trying to recall beats re-reading`
  String get onboarding6FunFactRetrievalTitle {
    return Intl.message(
      'Fun fact: Trying to recall beats re-reading',
      name: 'onboarding6FunFactRetrievalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Research shows that actively trying to remember (instead of re-reading) leads to noticeably better learning. In a large meta-analysis about 81% of results favored "try to recall" over "just review."`
  String get onboarding6FunFactRetrievalSubtitle {
    return Intl.message(
      'Research shows that actively trying to remember (instead of re-reading) leads to noticeably better learning. In a large meta-analysis about 81% of results favored "try to recall" over "just review."',
      name: 'onboarding6FunFactRetrievalSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `That's why answering questions helps your speaking stick.`
  String get onboarding6FunFactRetrievalHelper {
    return Intl.message(
      'That\'s why answering questions helps your speaking stick.',
      name: 'onboarding6FunFactRetrievalHelper',
      desc: '',
      args: [],
    );
  }

  /// `Got it`
  String get onboarding6GotIt {
    return Intl.message('Got it', name: 'onboarding6GotIt', desc: '', args: []);
  }

  /// `Practice speaking with AI in real time voice chat`
  String get onboarding6RealTimeVoiceTitle {
    return Intl.message(
      'Practice speaking with AI in real time voice chat',
      name: 'onboarding6RealTimeVoiceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Try translating a phrase out loud and get instant feedback or a helpful hint when you're stuck.`
  String get onboarding6RealTimeVoiceSubtitle {
    return Intl.message(
      'Try translating a phrase out loud and get instant feedback or a helpful hint when you\'re stuck.',
      name: 'onboarding6RealTimeVoiceSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Fun fact: Saying it out loud helps you remember`
  String get onboarding6FunFactProductionTitle {
    return Intl.message(
      'Fun fact: Saying it out loud helps you remember',
      name: 'onboarding6FunFactProductionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Studies show that speaking out loud can improve memory by about 10–20% compared to reading silently.`
  String get onboarding6FunFactProductionSubtitle {
    return Intl.message(
      'Studies show that speaking out loud can improve memory by about 10–20% compared to reading silently.',
      name: 'onboarding6FunFactProductionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your voice practice isn't just "practice" — it helps new phrases stick faster.`
  String get onboarding6FunFactProductionHelper {
    return Intl.message(
      'Your voice practice isn\'t just "practice" — it helps new phrases stick faster.',
      name: 'onboarding6FunFactProductionHelper',
      desc: '',
      args: [],
    );
  }

  /// `Nice`
  String get onboarding6Nice {
    return Intl.message('Nice', name: 'onboarding6Nice', desc: '', args: []);
  }

  /// `A personal tutor, whenever you need`
  String get onboarding6BetterThanSchedulingTitle {
    return Intl.message(
      'A personal tutor, whenever you need',
      name: 'onboarding6BetterThanSchedulingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Practice anytime you want, for less than a private tutor. No calendar. No pressure. Just real practice and gentle feedback`
  String get onboarding6BetterThanSchedulingSubtitle {
    return Intl.message(
      'Practice anytime you want, for less than a private tutor. No calendar. No pressure. Just real practice and gentle feedback',
      name: 'onboarding6BetterThanSchedulingSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose your teacher language`
  String get onboarding6TeacherLanguageTitle {
    return Intl.message(
      'Choose your teacher language',
      name: 'onboarding6TeacherLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `This is the language your tutor will speak to you in. You can change it anytime.`
  String get onboarding6TeacherLanguageSubtitle {
    return Intl.message(
      'This is the language your tutor will speak to you in. You can change it anytime.',
      name: 'onboarding6TeacherLanguageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose the language you want to learn`
  String get onboarding6TargetLanguageTitle {
    return Intl.message(
      'Choose the language you want to learn',
      name: 'onboarding6TargetLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can switch languages anytime.`
  String get onboarding6TargetLanguageSubtitle {
    return Intl.message(
      'You can switch languages anytime.',
      name: 'onboarding6TargetLanguageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `What's your current level?`
  String get onboarding6CurrentLevelTitle {
    return Intl.message(
      'What\'s your current level?',
      name: 'onboarding6CurrentLevelTitle',
      desc: '',
      args: [],
    );
  }

  /// `Just a rough estimate — we'll adapt as you practice.`
  String get onboarding6CurrentLevelSubtitle {
    return Intl.message(
      'Just a rough estimate — we\'ll adapt as you practice.',
      name: 'onboarding6CurrentLevelSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Pick a topic to start with`
  String get onboarding6StartTopicTitle {
    return Intl.message(
      'Pick a topic to start with',
      name: 'onboarding6StartTopicTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose what's most useful right now. You can change topics anytime.`
  String get onboarding6StartTopicSubtitle {
    return Intl.message(
      'Choose what\'s most useful right now. You can change topics anytime.',
      name: 'onboarding6StartTopicSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Creating your personal learning path`
  String get onboarding6LoadingText1 {
    return Intl.message(
      'Creating your personal learning path',
      name: 'onboarding6LoadingText1',
      desc: '',
      args: [],
    );
  }

  /// `Setting up your first lesson`
  String get onboarding6LoadingText2 {
    return Intl.message(
      'Setting up your first lesson',
      name: 'onboarding6LoadingText2',
      desc: '',
      args: [],
    );
  }

  /// `Preparing your AI tutor`
  String get onboarding6LoadingText3 {
    return Intl.message(
      'Preparing your AI tutor',
      name: 'onboarding6LoadingText3',
      desc: '',
      args: [],
    );
  }

  /// `Almost ready...`
  String get onboarding6LoadingText4 {
    return Intl.message(
      'Almost ready...',
      name: 'onboarding6LoadingText4',
      desc: '',
      args: [],
    );
  }

  /// `Speak with confidence — without the pressure`
  String get paywall5Headline {
    return Intl.message(
      'Speak with confidence — without the pressure',
      name: 'paywall5Headline',
      desc: '',
      args: [],
    );
  }

  /// `Your warm, judgment-free tutor, anytime.`
  String get paywall5Subheadline {
    return Intl.message(
      'Your warm, judgment-free tutor, anytime.',
      name: 'paywall5Subheadline',
      desc: '',
      args: [],
    );
  }

  /// `Speak with AI in real time (voice)`
  String get paywall5Benefit1 {
    return Intl.message(
      'Speak with AI in real time (voice)',
      name: 'paywall5Benefit1',
      desc: '',
      args: [],
    );
  }

  /// `Unlimited real-life topics`
  String get paywall5Benefit2 {
    return Intl.message(
      'Unlimited real-life topics',
      name: 'paywall5Benefit2',
      desc: '',
      args: [],
    );
  }

  /// `Any language, anytime`
  String get paywall5Benefit3 {
    return Intl.message(
      'Any language, anytime',
      name: 'paywall5Benefit3',
      desc: '',
      args: [],
    );
  }

  /// `Instant gentle corrections + more natural phrasing`
  String get paywall5Benefit4 {
    return Intl.message(
      'Instant gentle corrections + more natural phrasing',
      name: 'paywall5Benefit4',
      desc: '',
      args: [],
    );
  }

  /// `Start practicing`
  String get paywall5StartPracticing {
    return Intl.message(
      'Start practicing',
      name: 'paywall5StartPracticing',
      desc: '',
      args: [],
    );
  }

  /// `Travel`
  String get topicTravel {
    return Intl.message('Travel', name: 'topicTravel', desc: '', args: []);
  }

  /// `Food`
  String get topicFood {
    return Intl.message('Food', name: 'topicFood', desc: '', args: []);
  }

  /// `Sports`
  String get topicSports {
    return Intl.message('Sports', name: 'topicSports', desc: '', args: []);
  }

  /// `Music`
  String get topicMusic {
    return Intl.message('Music', name: 'topicMusic', desc: '', args: []);
  }

  /// `Movies`
  String get topicMovies {
    return Intl.message('Movies', name: 'topicMovies', desc: '', args: []);
  }

  /// `Books`
  String get topicBooks {
    return Intl.message('Books', name: 'topicBooks', desc: '', args: []);
  }

  /// `Technology`
  String get topicTechnology {
    return Intl.message(
      'Technology',
      name: 'topicTechnology',
      desc: '',
      args: [],
    );
  }

  /// `Art`
  String get topicArt {
    return Intl.message('Art', name: 'topicArt', desc: '', args: []);
  }

  /// `Fashion`
  String get topicFashion {
    return Intl.message('Fashion', name: 'topicFashion', desc: '', args: []);
  }

  /// `Nature`
  String get topicNature {
    return Intl.message('Nature', name: 'topicNature', desc: '', args: []);
  }

  /// `Cooking`
  String get topicCooking {
    return Intl.message('Cooking', name: 'topicCooking', desc: '', args: []);
  }

  /// `Photography`
  String get topicPhotography {
    return Intl.message(
      'Photography',
      name: 'topicPhotography',
      desc: '',
      args: [],
    );
  }

  /// `Fitness`
  String get topicFitness {
    return Intl.message('Fitness', name: 'topicFitness', desc: '', args: []);
  }

  /// `Gaming`
  String get topicGaming {
    return Intl.message('Gaming', name: 'topicGaming', desc: '', args: []);
  }

  /// `History`
  String get topicHistory {
    return Intl.message('History', name: 'topicHistory', desc: '', args: []);
  }

  /// `Science`
  String get topicScience {
    return Intl.message('Science', name: 'topicScience', desc: '', args: []);
  }

  /// `Business`
  String get topicBusiness {
    return Intl.message('Business', name: 'topicBusiness', desc: '', args: []);
  }

  /// `Education`
  String get topicEducation {
    return Intl.message(
      'Education',
      name: 'topicEducation',
      desc: '',
      args: [],
    );
  }

  /// `Health`
  String get topicHealth {
    return Intl.message('Health', name: 'topicHealth', desc: '', args: []);
  }

  /// `Culture`
  String get topicCulture {
    return Intl.message('Culture', name: 'topicCulture', desc: '', args: []);
  }

  /// `Politics`
  String get topicPolitics {
    return Intl.message('Politics', name: 'topicPolitics', desc: '', args: []);
  }

  /// `Economy`
  String get topicEconomy {
    return Intl.message('Economy', name: 'topicEconomy', desc: '', args: []);
  }

  /// `Entertainment`
  String get topicEntertainment {
    return Intl.message(
      'Entertainment',
      name: 'topicEntertainment',
      desc: '',
      args: [],
    );
  }

  /// `Lifestyle`
  String get topicLifestyle {
    return Intl.message(
      'Lifestyle',
      name: 'topicLifestyle',
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
