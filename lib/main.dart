import 'dart:convert';

import 'package:aussie/presentation/screens/settings/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:aussie/models/themes/themes.dart';
import 'package:aussie/presentation/screens/dyk.dart';
import 'package:aussie/presentation/screens/efe/efe.dart';
import 'package:aussie/presentation/screens/info/fauna.dart';
import 'package:aussie/presentation/screens/info/flora.dart';
import 'package:aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:aussie/presentation/screens/info/weather/weather.dart';
import 'package:aussie/presentation/screens/statistics/energy.dart';
import 'package:aussie/presentation/screens/statistics/gdp.dart';
import 'package:aussie/presentation/screens/statistics/heducation.dart';
import 'package:aussie/presentation/screens/statistics/livestock.dart';
import 'package:aussie/presentation/screens/statistics/religion.dart';
import 'package:aussie/presentation/screens/statistics/statistics.dart';
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
  runApp(MyApp(themeMap));
}

class MyApp extends StatelessWidget {
  final Map<String, dynamic> themeMap;
  final ThemeCubit _themeCubit;
  MyApp(this.themeMap)
      : assert(themeMap != null),
        _themeCubit = ThemeCubit(themeMap);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return BlocProvider<ThemeCubit>.value(
      value: _themeCubit,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        // ignore: missing_return
        builder: (context, state) {
          print(state.model.brightness);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(brightness: state.model.brightness),
            initialRoute: EFEScreen.navPath,
            routes: routes,
          );
        },
      ),
    );
  }

  static final Map<String, Widget Function(BuildContext)> routes = {
    NaturalParksScreen.navPath: (BuildContext context) => NaturalParksScreen(),
    DYKScreen.navPath: (BuildContext context) => DYKScreen(),
    WeatherScreen.navPath: (BuildContext context) => WeatherScreen(),
    TeritoriesScreen.navPath: (BuildContext context) => TeritoriesScreen(),
    EFEScreen.navPath: (BuildContext context) => EFEScreen(),
    StatisticsScreen.navPath: (BuildContext context) => StatisticsScreen(),
    FaunaScreen.navPath: (BuildContext context) => FaunaScreen(),
    FloraScreen.navPath: (BuildContext context) => FloraScreen(),
    ReligionScreen.navPath: (BuildContext context) => ReligionScreen(),
    EnergyScreen.navPath: (BuildContext context) => EnergyScreen(),
    LivestockScreen.navPath: (BuildContext context) => LivestockScreen(),
    GDPScreen.navPath: (BuildContext context) => GDPScreen(),
    HEducationScreen.navPath: (BuildContext context) => HEducationScreen(),
    SettingsScreen.navPath: (BuildContext context) => SettingsScreen(),
  };
}
