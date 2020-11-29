import 'package:aussie/models/weather/card.dart';
import 'package:aussie/models/weather/weather.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/weather_card.dart';
import 'package:aussie/presentation/widgets/aussie/weather_tile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/constants.dart';
import 'package:aussie/util/functions.dart';

class WeatherDetails extends StatelessWidget {
  final WeatherModel model;
  const WeatherDetails({@required this.model});
  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: .5.sh,
            elevation: 5,
            forceElevated: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.title),
              centerTitle: true,
              background: buildImage(kurl),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                WeatherCard(
                  day: WeatherCardChildModel(
                    model: model,
                    title: "${model.description}",
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
