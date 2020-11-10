import 'package:Aussie/presentation/screens/dyk.dart';
import 'package:Aussie/presentation/screens/efe/efe.dart';
import 'package:Aussie/presentation/screens/info/fauna.dart';
import 'package:Aussie/presentation/screens/info/flora.dart';
import 'package:Aussie/presentation/screens/info/info.dart';
import 'package:Aussie/presentation/screens/info/natural_parks/natural_parks.dart';
import 'package:Aussie/presentation/screens/info/teritories/teritories.dart';
import 'package:Aussie/presentation/screens/info/weather/weather.dart';
import 'package:Aussie/presentation/screens/statistics/energy.dart';
import 'package:Aussie/presentation/screens/statistics/gdp.dart';
import 'package:Aussie/presentation/screens/statistics/heducation.dart';
import 'package:Aussie/presentation/screens/statistics/livestock.dart';
import 'package:Aussie/presentation/screens/statistics/religion.dart';
import 'package:Aussie/presentation/screens/statistics/statistics.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Typography.material2018().black,
        brightness: Brightness.light,
      ),
      initialRoute: EFEScreen.navPath,
      routes: {
        NaturalParksScreen.navPath: (BuildContext context) =>
            NaturalParksScreen(),
        DYKScreen.navPath: (BuildContext context) => DYKScreen(),
        InfoScreen.navPath: (BuildContext context) => InfoScreen(),
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
      },
    );
  }
}
