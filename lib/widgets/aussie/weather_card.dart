import 'package:Aussie/models/paginated/weather/card.dart';
import 'package:Aussie/widgets/aussie/weather_card_child.dart';
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final WeatherCardChildModel day;
  final WeatherCardChildModel night;
  const WeatherCard({
    @required this.day,
    @required this.night,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          WeatherCardChild(
            color: Colors.blue,
            model: day,
          ),
          WeatherCardChild(
            color: Colors.black87,
            model: night,
          ),
        ],
      ),
    );
  }
}
