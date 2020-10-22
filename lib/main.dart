import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/info/species.dart';
import 'package:Aussie/screens/info/religion.dart';
import 'package:Aussie/screens/landing.dart';
import 'package:Aussie/screens/main.dart';
import 'package:Aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        "/info/religon": (BuildContext context) => ReligionScreen(),
        "/info/fauna": (BuildContext context) => SpeciesScreen(
              title: "Australian Fauna",
              models: [
                SpeciesDescriptionModel(
                  commonName: "null",
                  scientificName: "null",
                  type: "null",
                  titleImage: buildImage(kurl).first,
                  description: klorem,
                )
              ],
            ),
        "/info/flora": (BuildContext context) => SpeciesScreen(
              title: "Australian Flora",
              models: [
                SpeciesDescriptionModel(
                  commonName: "null",
                  scientificName: "null",
                  type: "null",
                  titleImage: buildImage(kurl).first,
                  description: klorem,
                ),
              ],
            ),
      },
    );
  }
}
