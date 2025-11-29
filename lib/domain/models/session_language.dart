/// Поддерживаемые языки
enum SessionLanguage {
  japanese,
  portugueseEuropean,
  portugueseBrazilian,
  spanish,
  french,
  italian,
  german,
  russian,
  english;

  String get value {
    switch (this) {
      case SessionLanguage.japanese:
        return 'japanese';
      case SessionLanguage.portugueseEuropean:
        return 'portuguese_european';
      case SessionLanguage.portugueseBrazilian:
        return 'portuguese_brazilian';
      case SessionLanguage.spanish:
        return 'spanish';
      case SessionLanguage.french:
        return 'french';
      case SessionLanguage.italian:
        return 'italian';
      case SessionLanguage.german:
        return 'german';
      case SessionLanguage.russian:
        return 'russian';
      case SessionLanguage.english:
        return 'english';
    }
  }

  static SessionLanguage? fromValue(String value) {
    switch (value) {
      case 'japanese':
        return SessionLanguage.japanese;
      case 'portuguese_european':
        return SessionLanguage.portugueseEuropean;
      case 'portuguese_brazilian':
        return SessionLanguage.portugueseBrazilian;
      case 'spanish':
        return SessionLanguage.spanish;
      case 'french':
        return SessionLanguage.french;
      case 'italian':
        return SessionLanguage.italian;
      case 'german':
        return SessionLanguage.german;
      case 'russian':
        return SessionLanguage.russian;
      case 'english':
        return SessionLanguage.english;
      default:
        return null;
    }
  }

  String get localizedName {
    switch (this) {
      case SessionLanguage.japanese:
        return '日本語';
      case SessionLanguage.portugueseEuropean:
        return 'Português (Europa)';
      case SessionLanguage.portugueseBrazilian:
        return 'Português (Brasil)';
      case SessionLanguage.spanish:
        return 'Español';
      case SessionLanguage.french:
        return 'Français';
      case SessionLanguage.italian:
        return 'Italiano';
      case SessionLanguage.german:
        return 'Deutsch';
      case SessionLanguage.russian:
        return 'Русский';
      case SessionLanguage.english:
        return 'English';
    }
  }
}
