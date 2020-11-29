import 'dart:ui';

import 'package:aussie/presentation/screens/statistics/energy.dart';
import 'package:aussie/presentation/screens/statistics/gdp.dart';
import 'package:aussie/presentation/screens/statistics/heducation.dart';
import 'package:aussie/presentation/screens/statistics/livestock.dart';
import 'package:aussie/presentation/screens/statistics/religion.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatisticsScreen extends StatelessWidget {
  static final navPath = "/main/statistics";
  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      appBar: AppBar(title: Text("Statistics"), elevation: 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildTile(
            ReligionScreen.navPath,
            ReligionScreen.svgName,
            ReligionScreen.title,
          ),
          buildTile(
            EnergyScreen.navPath,
            EnergyScreen.svgName,
            EnergyScreen.title,
          ),
          buildTile(
            LivestockScreen.navPath,
            LivestockScreen.svgName,
            LivestockScreen.title,
          ),
          buildTile(
            GDPScreen.navPath,
            GDPScreen.svgName,
            GDPScreen.title,
          ),
          buildTile(
            HEducationScreen.navPath,
            HEducationScreen.svgName,
            HEducationScreen.title,
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
