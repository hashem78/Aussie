import 'dart:convert';

import 'package:aussie/presentation/screens/usermanagement/initial.dart';
import 'package:aussie/presentation/screens/usermanagement/signup.dart';
import 'package:aussie/state/usermanagement/cubit/usermanagement_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:aussie/localizations.dart';
import 'package:aussie/models/themes/themes.dart';
import 'package:aussie/presentation/screens/feed/feed.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
import 'package:aussie/presentation/screens/misc/settings.dart';
import 'package:aussie/state/language/cubit/language_cubit.dart';
import 'package:aussie/state/themes/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  var _perfs = await SharedPreferences.getInstance();
  Map<String, dynamic> themeMap;
  if (_perfs.containsKey("theme")) {
    final String themeString = _perfs.get("theme");
    themeMap = jsonDecode(themeString);
  } else {
    themeMap = ThemeModel.defaultThemeMap;
    _perfs.setString("theme", jsonEncode(themeMap));
  }
  Locale locale;
  if (_perfs.containsKey("lang")) {
    locale = Locale(_perfs.getString("lang"), '');
  } else {
    _perfs.setString("lang", "en");
    locale = Locale('en', '');
  }
  runApp(MyApp(themeMap, locale));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> themeMap;
  final ThemeCubit _themeCubit;
  final LanguageCubit _languageCubit;
  final Locale locale;
  MyApp(this.themeMap, this.locale)
      : assert(themeMap != null && locale != null),
        _themeCubit = ThemeCubit(themeMap),
        _languageCubit = LanguageCubit(locale);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _themeCubit),
        BlocProvider.value(value: _languageCubit),
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => UserManagementCubit()),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
                locale: languageState.currentLocale,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  AussieLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale('en', ''),
                  const Locale('ar', ''),
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  if (supportedLocales.contains(locale)) return locale;
                  return supportedLocales.first;
                },
                home: InitialScreen(),
                theme: ThemeData(
                  brightness: state.model.brightness,
                ),
                routes: routes,
              );
            },
          );
        },
      ),
    );
  }

  static final routes = {
    "/feed": (BuildContext context) => FeedScreen(),
    NaturalParksScreen.data.navPath: (BuildContext context) =>
        NaturalParksScreen(),
    WeatherScreen.data.navPath: (BuildContext context) => WeatherScreen(),
    TeritoriesScreen.data.navPath: (BuildContext context) => TeritoriesScreen(),
    FaunaScreen.data.navPath: (BuildContext context) => FaunaScreen(),
    FloraScreen.data.navPath: (BuildContext context) => FloraScreen(),
    SettingsScreen.navPath: (BuildContext context) => SettingsScreen(),
  };
}
