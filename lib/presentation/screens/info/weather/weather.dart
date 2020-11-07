import 'package:Aussie/models/paginated/weather/weather.dart';
import 'package:Aussie/presentation/widgets/aussie/sliver_appbar.dart';
import 'package:Aussie/presentation/widgets/aussie/weather_tile.dart';

import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';

const String _iconTemp = 'wi-day-sunny';
const String _titleTemp = "Melborne";

class WeatherScreen extends StatelessWidget {
  static String navPath = "/main/info/weather";
  static String svgName = "weather.svg";
  static String title = "Weather";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          AussieSliverAppBar(
            title: WeatherScreen.title,
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            children: List.filled(
              6,
              WeatherTile(
                model: WeatherModel.withFourDays(
                  title: _titleTemp,
                  highIconString: _iconTemp,
                  lowIconString: _iconTemp,
                  imageUrl: kurl,
                  fourDayModels: [
                    WeatherModel(
                      highIconString: _iconTemp,
                      lowIconString: _iconTemp,
                      title: _titleTemp,
                      imageUrl: kurl,
                    ),
                    WeatherModel(
                      highIconString: _iconTemp,
                      lowIconString: _iconTemp,
                      title: _titleTemp,
                      imageUrl: kurl,
                    ),
                    WeatherModel(
                      highIconString: _iconTemp,
                      lowIconString: _iconTemp,
                      title: _titleTemp,
                      imageUrl: kurl,
                    ),
                    WeatherModel(
                      highIconString: _iconTemp,
                      lowIconString: _iconTemp,
                      title: _titleTemp,
                      imageUrl: kurl,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
