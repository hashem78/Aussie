import 'package:aussie/models/weather/card_model.dart';
import 'package:aussie/presentation/screens/info/weather/widgets/weather_card_child.dart';

import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final WeatherCardChildModel day;

  const WeatherCard({
    @required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return WeatherCardChild(
      model: day,
    );
  }
}
