import 'package:aussie/models/weather/weather.dart';
import 'package:aussie/presentation/screens/info/weather/details.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherTile extends StatelessWidget {
  final WeatherModel model;
  final bool showTitle;

  const WeatherTile({@required this.model, this.showTitle = false});

  @override
  Widget build(BuildContext context) {
    var _today = model;

    return Container(
      color: Colors.blue.shade700,
      height: .3.sh,
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  showTitle ? model.title : model.day,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 100.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: BoxedIcon(
                    WeatherIcons.fromString(model.iconString),
                    size: 250.sp,
                    color: Colors.amber,
                  ),
                ),
                AutoSizeText(
                  "${model.highTemp}°C",
                  softWrap: true,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 100.sp,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return WeatherDetails(model: _today);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
