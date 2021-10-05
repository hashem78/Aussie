import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AussieLocalizations {
  AussieLocalizations(this.locale);
  static const _AussieLocalizationsDelegate delegate =
      _AussieLocalizationsDelegate();

  final Locale locale;

  static AussieLocalizations of(BuildContext context) {
    return Localizations.of<AussieLocalizations>(context, AussieLocalizations)!;
  }

  late Map<String, String> _localizedStrings;

  Future<void> load(Locale locale) async {
    final _assetData =
        await rootBundle.loadString("assets/json/${locale.languageCode}.json");
    final Map<String, dynamic> _map =
        jsonDecode(_assetData) as Map<String, dynamic>;
    _localizedStrings = Map<String, String>.from(_map);
  }

  String translate(String key) {
    return _localizedStrings[key]!;
  }
}

class _AussieLocalizationsDelegate
    extends LocalizationsDelegate<AussieLocalizations> {
  const _AussieLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AussieLocalizations> load(Locale locale) async {
    final AussieLocalizations localizations = AussieLocalizations(locale);
    await localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AussieLocalizations> old) =>
      false;
}
