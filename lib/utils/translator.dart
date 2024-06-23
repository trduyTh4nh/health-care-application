import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class AppLocalizations {
  final Locale locale;
  final GoogleTranslator translator = GoogleTranslator();

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Future<String> translate(String key) async {
    switch (key) {
      case 'hello':
        final translation = await translator.translate('Hello', to: locale.languageCode);
        return translation.text;
      case 'welcome':
        final translation = await translator.translate('Welcome', to: locale.languageCode);
        return translation.text;
      default:
        return key;
    }
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'pt', 'ru', 'pl'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;
}
