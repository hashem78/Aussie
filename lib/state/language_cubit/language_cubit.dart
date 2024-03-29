import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/painting.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit(Locale initialLocale) : super(LanguageInitial(initialLocale));

  Future<void> changeLocale(Locale newLocale) async {
    final SharedPreferences _perfs = await SharedPreferences.getInstance();
    _perfs.setString('lang', newLocale.languageCode);
    emit(LanguageChanged(newLocale));
  }

  Locale get locale => state.currentLocale;
}
