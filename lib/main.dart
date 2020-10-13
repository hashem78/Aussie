import 'package:Aussie/screens/explore.dart';
import 'package:Aussie/screens/main.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print(await DataConnectionChecker().hasConnection);

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
        "/": (BuildContext context) => MainScreen(),
        "/explore": (BuildContext context) => ExploreScreen(),
      },
    );
  }
}
