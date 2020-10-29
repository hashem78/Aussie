import 'package:Aussie/screens/info/fauna.dart';
import 'package:Aussie/screens/info/flora.dart';
import 'package:Aussie/screens/info/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  static final navPath = "/main/info";
  static final title = "Info";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
        ],
      ),
    );
  }

  Widget buildTile(String route, String svgName, String title) => Builder(
        builder: (BuildContext context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: Ink(
            color: Colors.deepPurple,
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
// Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
//             child: Ink(
//               color: Colors.deepPurple,
//               child: ListTile(
//                 leading: SizedBox.fromSize(
//                   size: Size(30, 30),
//                   child: SvgPicture.asset(
//                     'assests/images/fauna.svg',
//                   ),
//                 ),
//                 title: Text("Australlian fauna"),
//                 onTap: () => Navigator.pushNamed(context, "/statistics/fauna"),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
//             child: Ink(
//               color: Colors.deepPurple,
//               child: ListTile(
//                 leading: SizedBox.fromSize(
//                   size: Size(30, 30),
//                   child: SvgPicture.asset(
//                     'assests/images/flora.svg',
//                   ),
//                 ),
//                 title: Text("Australlian flora"),
//                 onTap: () => Navigator.pushNamed(context, "/statistics/flora"),
//               ),
//             ),
//           ),
