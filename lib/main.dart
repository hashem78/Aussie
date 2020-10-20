import 'package:Aussie/screens/info/religion.dart';
import 'package:Aussie/screens/landing.dart';
import 'package:Aussie/screens/main.dart';
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
      },
    );
  }
}
