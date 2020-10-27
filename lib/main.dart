import 'package:Aussie/screens/statistics/gdp.dart';
import 'package:Aussie/screens/statistics/heducation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/landing.dart';
import 'package:Aussie/screens/main.dart';
import 'package:Aussie/screens/statistics/energy.dart';
import 'package:Aussie/screens/statistics/livestock.dart';
import 'package:Aussie/screens/statistics/religion.dart';
import 'package:Aussie/screens/statistics/species.dart';
import 'package:Aussie/util/functions.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
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
        ReligionScreen.navPath: (BuildContext context) => ReligionScreen(),
        "/statistics/fauna": (BuildContext context) => SpeciesScreen(
              title: "Australian Fauna",
              models: [
                SpeciesDescriptionModel(
                  commonName: "null",
                  scientificName: "null",
                  type: "null",
                  titleImage: buildImage(kurl),
                  description: klorem,
                )
              ],
            ),
        "/statistics/flora": (BuildContext context) => SpeciesScreen(
              title: "Australian Flora",
              models: [
                SpeciesDescriptionModel(
                  commonName: "null",
                  scientificName: "null",
                  type: "null",
                  titleImage: buildImage(kurl),
                  description: klorem,
                ),
              ],
            ),
        EnergyScreen.navPath: (BuildContext context) => EnergyScreen(),
        LivestockScreen.navPath: (BuildContext context) => LivestockScreen(),
        GDPScreen.navPath: (BuildContext context) => GDPScreen(),
        HEducationScreen.navPath: (BuildContext context) => HEducationScreen(),
      },
    );
  }
}
