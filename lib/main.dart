import 'package:Aussie/screens/efe/efe.dart';
import 'package:Aussie/screens/info/fauna.dart';
import 'package:Aussie/screens/info/flora.dart';
import 'package:Aussie/screens/info/info.dart';
import 'package:Aussie/screens/info/weather.dart';
import 'package:Aussie/screens/statistics/gdp.dart';
import 'package:Aussie/screens/statistics/heducation.dart';
import 'package:Aussie/screens/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Aussie/screens/landing.dart';
import 'package:Aussie/screens/main.dart';
import 'package:Aussie/screens/statistics/energy.dart';
import 'package:Aussie/screens/statistics/livestock.dart';
import 'package:Aussie/screens/statistics/religion.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
  //print(await DataConnectionChecker().hasConnection);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Typography.material2018().white,
      ),
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => LandingScreen(),
        "/main": (BuildContext context) => MainScreen(),
        InfoScreen.navPath: (BuildContext context) => InfoScreen(),
        WeatherScreen.navPath: (BuildContext context) => WeatherScreen(),
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
