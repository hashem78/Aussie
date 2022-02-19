import 'package:aussie/aussie_imports.dart';
import 'package:aussie/state/shared_prefrences.dart';
import 'package:riverpod/riverpod.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier(Locale initialState, this.ref) : super(initialState);

  final Ref ref;

  void changeTo(Locale newLocale) {
    final prefs = ref.read(sharedPrefrencesProvider);
    prefs.setString('lang', newLocale.languageCode);
    state = newLocale;
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>(
  (Ref ref) {
    final prefs = ref.read(sharedPrefrencesProvider);
    var lang = prefs.getString('lang');
    if (lang == null) {
      prefs.setString('lang', 'en');
      lang = 'en';
    }

    return LocaleNotifier(Locale(lang, ''), ref);
  },
);
