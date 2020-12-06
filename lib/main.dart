import 'dart:convert';

import 'package:aussie/localizations.dart';
import 'package:aussie/presentation/screens/in_aus/entertainment.dart';
import 'package:aussie/presentation/screens/in_aus/events.dart';
import 'package:aussie/presentation/screens/in_aus/food_drinks.dart';
import 'package:aussie/presentation/screens/in_aus/main.dart';
import 'package:aussie/presentation/screens/in_aus/people.dart';
import 'package:aussie/presentation/screens/in_aus/places.dart';
import 'package:aussie/presentation/screens/misc/settings.dart';

import 'package:aussie/presentation/widgets/aussie/scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/state/language/cubit/language_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:aussie/models/themes/themes.dart';
import 'package:aussie/presentation/screens/info/species/fauna.dart';
import 'package:aussie/presentation/screens/info/species/flora.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
import 'package:aussie/presentation/screens/statistics/energy.dart';
import 'package:aussie/presentation/screens/statistics/gdp.dart';
import 'package:aussie/presentation/screens/statistics/heducation.dart';
import 'package:aussie/presentation/screens/statistics/livestock.dart';
import 'package:aussie/presentation/screens/statistics/religion.dart';
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
        BlocProvider<ThemeCubit>.value(value: _themeCubit),
        BlocProvider<LanguageCubit>.value(value: _languageCubit),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, languageState) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Provider<AussieAppDrawer>(
                create: (context) => AussieAppDrawer(),
                child: MaterialApp(
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
                  home: AussieScaffold(body: MainScreen()),
                  theme: ThemeData(
                    brightness: state.model.brightness,
                  ),
                  routes: routes,
                ),
              );
            },
          );
        },
      ),
    );
  }

  static final Map<String, Widget Function(BuildContext)> routes = {
    NaturalParksScreen.data.navPath: (BuildContext context) =>
        NaturalParksScreen(),
    WeatherScreen.data.navPath: (BuildContext context) => WeatherScreen(),
    TeritoriesScreen.data.navPath: (BuildContext context) => TeritoriesScreen(),
    MainScreen.navPath: (BuildContext context) => MainScreen(),
    FaunaScreen.data.navPath: (BuildContext context) => FaunaScreen(),
    FloraScreen.data.navPath: (BuildContext context) => FloraScreen(),
    ReligionScreen.data.navPath: (BuildContext context) => ReligionScreen(),
    EnergyScreen.navPath: (BuildContext context) => EnergyScreen(),
    LivestockScreen.navPath: (BuildContext context) => LivestockScreen(),
    GDPScreen.navPath: (BuildContext context) => GDPScreen(),
    HEducationScreen.navPath: (BuildContext context) => HEducationScreen(),
    SettingsScreen.navPath: (BuildContext context) => SettingsScreen(),
    PeopleScreen.data.navPath: (BuildContext context) => PeopleScreen(),
    PlacesScreen.data.navPath: (BuildContext context) => PlacesScreen(),
    FoodScreen.data.navPath: (BuildContext context) => FoodScreen(),
    EntertainmentScreen.data.navPath: (BuildContext context) =>
        EntertainmentScreen(),
    EventsScreen.data.navPath: (BuildContext context) => EventsScreen(),
  };
}
