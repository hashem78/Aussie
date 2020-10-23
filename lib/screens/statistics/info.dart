import 'package:Aussie/screens/statistics/energy.dart';
import 'package:Aussie/screens/statistics/livestock.dart';
import 'package:Aussie/screens/statistics/religion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: Text("Statistics"), elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: Ink(
              color: Colors.deepPurple,
              child: ListTile(
                leading: SizedBox.fromSize(
                  size: Size(30, 30),
                  child: SvgPicture.asset(
                    'assests/images/${ReligionScreen.svgName}',
                  ),
                ),
                title: Text(ReligionScreen.title),
                onTap: () =>
                    Navigator.pushNamed(context, ReligionScreen.navPath),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: Ink(
              color: Colors.deepPurple,
              child: ListTile(
                leading: SizedBox.fromSize(
                  size: Size(30, 30),
                  child: SvgPicture.asset(
                    'assests/images/fauna.svg',
                  ),
                ),
                title: Text("Australlian fauna"),
                onTap: () => Navigator.pushNamed(context, "/statistics/fauna"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: Ink(
              color: Colors.deepPurple,
              child: ListTile(
                leading: SizedBox.fromSize(
                  size: Size(30, 30),
                  child: SvgPicture.asset(
                    'assests/images/flora.svg',
                  ),
                ),
                title: Text("Australlian flora"),
                onTap: () => Navigator.pushNamed(context, "/statistics/flora"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: Ink(
              color: Colors.deepPurple,
              child: ListTile(
                leading: SizedBox.fromSize(
                  size: Size(30, 30),
                  child: SvgPicture.asset(
                    'assests/images/${EnergyScreen.svgName}',
                  ),
                ),
                title: Text(EnergyScreen.title),
                onTap: () => Navigator.pushNamed(context, EnergyScreen.navPath),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            child: Ink(
              color: Colors.deepPurple,
              child: ListTile(
                leading: SizedBox.fromSize(
                  size: Size(30, 30),
                  child: SvgPicture.asset(
                    'assests/images/${LivestockScreen.svgName}',
                  ),
                ),
                title: Text("Livestock in Australlia"),
                onTap: () =>
                    Navigator.pushNamed(context, LivestockScreen.navPath),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
