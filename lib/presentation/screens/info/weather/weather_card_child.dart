import 'package:aussie/models/weather/card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherCardChild extends StatelessWidget {
  final Color color;
  final WeatherCardChildModel model;
  const WeatherCardChild({
    this.color,
    @required this.model,
  });
  @override
  Widget build(BuildContext context) {
    final _weatherModel = model.model;
    return ColoredBox(
      color: Colors.yellow,
      child: Column(
        children: [
          Text(
            _weatherModel.day,
            style: TextStyle(
              fontSize: 150.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          Row(
            children: [
              BoxedIcon(
                WeatherIcons.fromString(_weatherModel.iconString),
                size: 200.sp,
                color: Colors.teal,
              ),
              Expanded(
                child: Column(
                  children: [
                    AutoSizeText(
                      "H ${_weatherModel.highTemp}°C",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 120.sp, fontWeight: FontWeight.w600),
                    ),
                    AutoSizeText(
                      "L ${_weatherModel.lowTemp}°C",
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 120.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 40),
          ),
          Align(
            alignment: FractionalOffset.bottomLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
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
                    children: [
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
      ),
    );
  }
}
