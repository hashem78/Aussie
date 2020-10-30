import 'package:Aussie/widgets/aussie/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/models/weather/card.dart';
import 'package:Aussie/models/weather/weather.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/aussie/weather_tile.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherModel model;
  const WeatherDetails({@required this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            backgroundColor: Colors.green,
            expandedHeight: .4.sh,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.title),
              centerTitle: true,
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: buildImage(kurl),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                WeatherCard(
                  day: WeatherCardChildModel(
                    icon: model.highIconString,
                    temp: model.highTemp,
                    state: model.state,
                    title: "it's ${model.state} here in ${model.title}",
                  ),
                  night: WeatherCardChildModel(
                    icon: model.lowIconString,
                    temp: model.lowTemp,
                    state: model.lowState,
                    title: "Beign ${model.lowState} at night",
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: model.fourDayModels.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AbsorbPointer(
                        child: WeatherTile(model: model.fourDayModels[index]),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
