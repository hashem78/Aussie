import 'package:aussie/models/weather/weather_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_icons/weather_icons.dart';

import 'package:aussie/models/weather/card_model.dart';

class WeatherCardChild extends StatelessWidget {
  final Color? color;
  final WeatherCardChildModel model;
  const WeatherCardChild({
    Key? key,
    this.color,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final WeatherModel _weatherModel = model.model;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          _weatherModel.day!,
          style: TextStyle(
            fontSize: 150.sp,
            fontWeight: FontWeight.w900,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BoxedIcon(
              WeatherIcons.fromString(_weatherModel.iconString!),
              size: 200.sp,
              color: Colors.teal,
            ),
            Column(
              children: <Widget>[
                AutoSizeText(
                  'H ${_weatherModel.highTemp}°C',
                  maxLines: 1,
                  style:
                      TextStyle(fontSize: 120.sp, fontWeight: FontWeight.w600),
                ),
                AutoSizeText(
                  'L ${_weatherModel.lowTemp}°C',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 120.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          model.title!,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 40),
        ),
        Align(
          alignment: FractionalOffset.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/humidity.svg',
                      height: 30,
                    ),
                    Text(
                      _weatherModel.humidity.toString(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/barometer.svg',
                      height: 30,
                    ),
                    Text(
                      _weatherModel.pressure.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
