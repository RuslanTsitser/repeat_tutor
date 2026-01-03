import 'package:flutter/cupertino.dart';

/// Поддерживаемые языки
enum Language {
  english,
  spanish,
  french,
  italian,
  german,
  portugueseEuropean,
  russian,
  portugueseBrazilian,
  japanese;

  String get value {
    switch (this) {
      case Language.japanese:
        return 'japanese';
      case Language.portugueseEuropean:
        return 'portuguese_european';
      case Language.portugueseBrazilian:
        return 'portuguese_brazilian';
      case Language.spanish:
        return 'spanish';
      case Language.french:
        return 'french';
      case Language.italian:
        return 'italian';
      case Language.german:
        return 'german';
      case Language.russian:
        return 'russian';
      case Language.english:
        return 'english';
    }
  }

  static Language? fromLanguage(String language) {
    switch (language) {
      case 'japanese':
        return Language.japanese;
      case 'portuguese_european':
        return Language.portugueseEuropean;
      case 'portuguese_brazilian':
        return Language.portugueseBrazilian;
      case 'spanish':
        return Language.spanish;
      case 'french':
        return Language.french;
      case 'italian':
        return Language.italian;
      case 'german':
        return Language.german;
      case 'russian':
        return Language.russian;
      case 'english':
        return Language.english;
      default:
        return null;
    }
  }

  String get localizedName {
    switch (this) {
      case Language.japanese:
        return '日本語';
      case Language.portugueseEuropean:
        return 'Português (Europa)';
      case Language.portugueseBrazilian:
        return 'Português (Brasil)';
      case Language.spanish:
        return 'Español';
      case Language.french:
        return 'Français';
      case Language.italian:
        return 'Italiano';
      case Language.german:
        return 'Deutsch';
      case Language.russian:
        return 'Русский';
      case Language.english:
        return 'English';
    }
  }

  String get localeCode {
    switch (this) {
      case Language.japanese:
        return 'ja';
      case Language.portugueseEuropean:
      case Language.portugueseBrazilian:
        return 'pt';
      case Language.spanish:
        return 'es';
      case Language.french:
        return 'fr';
      case Language.italian:
        return 'it';
      case Language.german:
        return 'de';
      case Language.russian:
        return 'ru';
      case Language.english:
        return 'en';
    }
  }

  /// Конвертирует Language в Locale для использования в приложении
  Locale toLocale() {
    switch (this) {
      case Language.japanese:
        return const Locale.fromSubtags(languageCode: 'ja');
      case Language.portugueseEuropean:
        return const Locale.fromSubtags(languageCode: 'pt', countryCode: 'PT');
      case Language.portugueseBrazilian:
        return const Locale.fromSubtags(languageCode: 'pt');
      case Language.spanish:
        return const Locale.fromSubtags(languageCode: 'es');
      case Language.french:
        return const Locale.fromSubtags(languageCode: 'fr');
      case Language.italian:
        return const Locale.fromSubtags(languageCode: 'it');
      case Language.german:
        return const Locale.fromSubtags(languageCode: 'de');
      case Language.russian:
        return const Locale.fromSubtags(languageCode: 'ru');
      case Language.english:
        return const Locale.fromSubtags(languageCode: 'en');
    }
  }

  static Language fromLocaleCode(String localeCode, {String? countryCode}) {
    switch (localeCode) {
      case 'ja':
        return Language.japanese;
      case 'pt':
        return countryCode == 'PT'
            ? Language.portugueseEuropean
            : Language.portugueseBrazilian;
      case 'es':
        return Language.spanish;
      case 'fr':
        return Language.french;
      case 'it':
        return Language.italian;
      case 'de':
        return Language.german;
      case 'ru':
        return Language.russian;
      case 'en':
        return Language.english;
      default:
        return Language.english;
    }
  }
}
