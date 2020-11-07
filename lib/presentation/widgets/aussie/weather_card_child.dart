import 'package:Aussie/models/paginated/weather/card.dart';
import 'package:flutter/material.dart';
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
    return ColoredBox(
      color: color,
      child: Column(
        children: [
          Row(
            children: [
              BoxedIcon(
                WeatherIcons.fromString(model.icon),
                size: 100,
                color: Colors.yellow,
              ),
              Expanded(
                child: Text(
                  "${model.temp}°C",
                  style: TextStyle(fontSize: 90),
                ),
              ),
            ],
          ),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}
