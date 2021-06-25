import 'package:aussie/models/weather/card_model.dart';
import 'package:aussie/models/weather/weather_model.dart';
import 'package:aussie/presentation/screens/info/weather/widgets/weather_card.dart';
import 'package:aussie/presentation/screens/info/weather/widgets/weather_tile.dart';
import 'package:flutter/material.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherModel model;
  const WeatherDetails({required this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        elevation: 0,
        title: Text(model.title!),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: WeatherCard(
              day: WeatherCardChildModel(
                model: model,
                title: model.description,
              ),
            ),
          ),
          GridView.builder(
            itemCount: 4,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return AbsorbPointer(
                child: WeatherTile(
                  model: model.fourDayModels![index],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
