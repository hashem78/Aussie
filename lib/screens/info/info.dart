import 'package:Aussie/screens/info/fauna.dart';
import 'package:Aussie/screens/info/flora.dart';
import 'package:Aussie/screens/info/natural_parks/natural_parks.dart';
import 'package:Aussie/screens/info/teritories/teritories.dart';
import 'package:Aussie/screens/info/weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  static final navPath = "/main/info";
  static final title = "Info";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTile(
            FaunaScreen.navPath,
            FaunaScreen.svgName,
            FaunaScreen.title,
          ),
          buildTile(
            FloraScreen.navPath,
            FloraScreen.svgName,
            FloraScreen.title,
          ),
          buildTile(
            WeatherScreen.navPath,
            WeatherScreen.svgName,
            WeatherScreen.title,
          ),
          buildTile(
            TeritoriesScreen.navPath,
            TeritoriesScreen.svgName,
            TeritoriesScreen.title,
          ),
          buildTile(
            NaturalParksScreen.navPath,
            NaturalParksScreen.svgName,
            NaturalParksScreen.title,
          ),
        ],
      ),
    );
  }

  Widget buildTile(String route, String svgName, String title) => Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: Ink(
            child: ListTile(
              leading: SizedBox.fromSize(
                size: Size(30, 30),
                child: SvgPicture.asset(
                  'assests/images/$svgName',
                ),
              ),
              title: Text(title),
              onTap: () => Navigator.pushNamed(context, route),
            ),
          ),
        ),
      );
}
