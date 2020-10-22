import 'package:Aussie/widgets/aussie_sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool _) => [
          AussieSliverAppBar(
            title: "Info",
            showHero: false,
            backgroundColor: Colors.blue,
          )
        ],
        body: ListView(
          children: [
            //AussieBarChart(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              child: Ink(
                color: Colors.deepPurple,
                child: ListTile(
                  leading: SizedBox.fromSize(
                    size: Size(30, 30),
                    child: SvgPicture.asset(
                      'assests/images/pray.svg',
                    ),
                  ),
                  title: Text("Religon in australia"),
                  onTap: () => Navigator.pushNamed(context, "/info/religon"),
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
                  onTap: () => Navigator.pushNamed(context, "/info/fauna"),
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
                  onTap: () => Navigator.pushNamed(context, "/info/flora"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
