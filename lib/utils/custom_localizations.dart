import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

Map<String, Map<String, String>> _localizedSimpleValues = {};

Map<String, Map<String, Map<String, String>>> _localizedValues = {};

/// set localized simple values.
void setLocalizedSimpleValues(
    Map<String, Map<String, String>> localizedValues) {
  _localizedSimpleValues = localizedValues;
}

/// set localized values.
void setLocalizedValues(
    Map<String, Map<String, Map<String, String>>> localizedValues) {
  _localizedValues = localizedValues;
}


/// CustomLocalizations.
class CustomLocalizations {
  CustomLocalizations(this.locale);

  Locale locale;
  static CustomLocalizations instance;

  ///不推荐使用.
  // static void init(BuildContext context) {
  //   instance = of(context);
  // }

  static CustomLocalizations of(BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations);
  }

  /// get string by id,Can be specified languageCode,countryCode.
  /// 通过id获取字符串,可指定languageCode,countryCode.
  String getString(String id, {String languageCode, String countryCode}) {
    String _languageCode = languageCode ?? locale.languageCode;
    if (_localizedSimpleValues.isNotEmpty) {
      return _localizedSimpleValues[_languageCode][id];
    } else {
      String _countryCode = countryCode ?? locale.countryCode;
      if (_countryCode == null ||
          _countryCode.isEmpty ||
          !_localizedValues[_languageCode].keys.contains(_countryCode)) {
        _countryCode = _localizedValues[_languageCode].keys.toList()[0];
      }
      return _localizedValues[_languageCode][_countryCode][id];
    }
  }

  /// supported Locales
  static Iterable<Locale> supportedLocales = _getSupportedLocales();

  static List<Locale> _getSupportedLocales() {
    List<Locale> list = new List();
    if (_localizedSimpleValues.isNotEmpty) {
      _localizedSimpleValues.keys.forEach((value) {
        list.add(new Locale(value, ''));
      });
    } else {
      _localizedValues.keys.forEach((value) {
        _localizedValues[value].keys.forEach((vv) {
          list.add(new Locale(value, vv));
        });
      });
    }
    return list;
  }

  static const LocalizationsDelegate<CustomLocalizations> delegate =
      _CustomLocalizationsDelegate();
}

class _CustomLocalizationsDelegate
    extends LocalizationsDelegate<CustomLocalizations> {
  const _CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => (_localizedSimpleValues.isNotEmpty
      ? _localizedSimpleValues.keys.contains(locale.languageCode)
      : _localizedValues.keys.contains(locale.languageCode));

  @override
  Future<CustomLocalizations> load(Locale locale) {
    return new SynchronousFuture<CustomLocalizations>(
        new CustomLocalizations(locale));
  }

  @override
  bool shouldReload(_CustomLocalizationsDelegate old) => false;
}
