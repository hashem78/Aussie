import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/info/info.dart';
import 'package:Aussie/screens/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AussieAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: kausBlue),
      child: Drawer(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2.0,
              child: SvgPicture.asset('assests/images/au.svg'),
            ),
            buildTile(
              "Information about Australia",
              InfoScreen.navPath,
              Icons.info,
            ),
            buildTile(
              "Australia in numbers",
              StatisticsScreen.navPath,
              Icons.info,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTile(String title, String path, IconData icon) {
    return Builder(
      builder: (BuildContext context) => Ink(
        color: Colors.lightBlue,
        child: ListTile(
          onTap: () => Navigator.of(context).pushNamed(path),
          // tileColor: Colors.purple,
          leading: Icon(icon),
          title: Text(title),
        ),
      ),
    );
  }
}
