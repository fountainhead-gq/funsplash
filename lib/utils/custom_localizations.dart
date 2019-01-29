import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const supportedLocales = const ['en', 'zh'];

class FunsplashLocalizations {
  FunsplashLocalizations(this.locale);

  final Locale locale;

  static FunsplashLocalizations of(BuildContext context) {
    return Localizations.of<FunsplashLocalizations>(
        context, FunsplashLocalizations);
  }

  Map<String, Object> sentences;

  Future<bool> load() async {
    print(this.locale.languageCode);
    String data = await rootBundle
        .loadString('assets/localization/${this.locale.languageCode}.json');
    sentences = json.decode(data);
    return true;
  }

  String trans(String key) {
    return sentences[key];
  }

  static FunsplashLocalizationsDelegate delegate =
      const FunsplashLocalizationsDelegate();
}

class FunsplashLocalizationsDelegate
    extends LocalizationsDelegate<FunsplashLocalizations> {
  const FunsplashLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      supportedLocales.contains(locale.languageCode);

  @override
  Future<FunsplashLocalizations> load(Locale locale) async {
    FunsplashLocalizations localizations = new FunsplashLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(FunsplashLocalizationsDelegate old) => false;
}
