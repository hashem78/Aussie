import 'package:aussie/models/weather/weather_model.dart';
import 'package:aussie/presentation/screens/info/weather/details.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherTile extends StatelessWidget {
  final WeatherModel model;
  final bool showTitle;

  const WeatherTile({required this.model, this.showTitle = false});

  @override
  Widget build(BuildContext context) {
    final _today = model;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return WeatherDetails(model: _today);
            },
          ),
        );
      },
      child: Column(
        children: [
          AutoSizeText(
            showTitle ? model.title ?? "Title" : model.day!,
            maxLines: 1,
            style: TextStyle(
              fontSize: 150.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          BoxedIcon(
            WeatherIcons.fromString(model.iconString ?? "wi-day-sunny"),
            size: 250.sp,
            color: Colors.amber,
          ),
          AutoSizeText(
            "${model.highTemp}°C",
            softWrap: true,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 150.sp,
              color: Colors.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
