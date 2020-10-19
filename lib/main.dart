import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/landing.dart';
import 'package:Aussie/screens/main.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/aussie_sliver_appbar.dart';
import 'package:Aussie/widgets/sized_tile.dart';
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
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kausBlue,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool extened) => [
          AussieSliverAppBar(title: "Main", showHero: true),
        ],
        body: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(5),
          children: [
            SizedTile.withDetails(
              title: "About famous celebs, the food and what keeps em ticking.",
              swatchMaxLines: 3,
              widthFactor: 100,
              swatchColor: Colors.red,
              heightFactor: 30,
              image: buildImage(kurl),
              child: EFEScreen(),
            ),
            SizedBox(height: 5),
            SizedTile(
              title: "About famous celebs, the food and what keeps em ticking.",
              swatchMaxLines: 3,
              widthFactor: 100,
              swatchColor: Colors.red,
              heightFactor: 30,
              image: buildImage(kurl),
            ),
          ],
        ),
      ),
    );
  }
}
