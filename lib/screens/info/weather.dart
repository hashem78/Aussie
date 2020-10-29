import 'package:Aussie/constants.dart';
import 'package:Aussie/widgets/aussie/sliver_appbar.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherScreen extends StatefulWidget {
  static String navPath = "/main/info/weather";
  static String svgName = "weather.svg";
  static String title = "Weather";

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kausBlue,
      body: CustomScrollView(
        slivers: [
          AussieSliverAppBar(
            title: WeatherScreen.title,
            showHero: false,
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            children: List.filled(
              10,
              WeatherTile(),
            ),
          )
        ],
      ),
    );
  }
}

class WeatherTile extends StatefulWidget {
  @override
  _WeatherTileState createState() => _WeatherTileState();
}

class _WeatherTileState extends State<WeatherTile> {
  final double _defaultMargin = 2.5;
  final double _defaultIconSize = 60;
  double margin;
  double iconSize;
  @override
  void initState() {
    super.initState();
    margin = _defaultMargin;
    iconSize = _defaultIconSize;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (_) {
        setState(() {
          margin = 3 * _defaultMargin;
          iconSize = _defaultIconSize / 1.2;
        });
      },
      onPanCancel: () {
        setState(() {
          margin = _defaultMargin;
          iconSize = _defaultIconSize;
        });
      },
      onPanEnd: (_) {
        setState(() {
          margin = _defaultMargin;
          iconSize = _defaultIconSize;
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(margin),
        duration: Duration(milliseconds: 50),
        color: Colors.blue,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              child: Align(
                alignment: FractionalOffset.topCenter,
                child: BoxedIcon(
                  WeatherIcons.fromString('wi-day-sunny'),
                  size: iconSize,
                  color: Colors.yellow,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Melborne",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sunny",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
