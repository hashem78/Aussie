import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/models/themes/screen_data.dart';

import 'package:aussie/presentation/widgets/animated/pie_chart.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:flutter/material.dart';

import 'package:aussie/models/aussie_pie_chart.dart';

import 'package:aussie/util/functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReligionScreen extends StatelessWidget {
  static final AussieScreenData data = AussieScreenData(
    tTitle: "religonTitle",
    navPath: "/statistics/religon",
    svgName: "pray.svg",
    themeAttribute: "religionScreenColor",
    thumbnailRoute: "nan",
    light: AussieColorData(
      swatchColor: Colors.blue,
      backgroundColor: Colors.lightBlue,
    ),
    dark: AussieColorData(
      swatchColor: Colors.blue.shade900,
      backgroundColor: Colors.lightBlue.shade900,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      drawer: getAppDrawer(context),
      backgroundColor: Colors.blue,
      body: _buildReligonPieChart(),
    );
  }

  Widget _buildReligonPieChart() {
    return CustomScrollView(
      slivers: [
        AussieSliverAppBar(
          Colors.lightBlue,
          "Religions",
          height: .3.sh,
          fit: BoxFit.fill,
        ),
        SliverPadding(padding: EdgeInsets.symmetric(vertical: .03.sh)),
        SliverToBoxAdapter(
          child: AussiePieChart(
            chartData: [
              AussiePieChartModel(
                sectionTitle: "islam",
                value: 60.42,
                color: Colors.green,
                hasBadge: true,
              ),
              AussiePieChartModel(
                sectionTitle: "hinduism",
                value: 44.03,
                color: Colors.pink,
                hasBadge: true,
              ),
              AussiePieChartModel(
                sectionTitle: "judaism",
                value: 31.91,
                color: Colors.red,
                hasBadge: true,
              ),
              AussiePieChartModel(
                sectionTitle: "sikhism",
                value: 12.5,
                color: Colors.black,
                hasBadge: true,
              ),
              AussiePieChartModel(
                sectionTitle: "christian",
                value: 122.016,
                hasBadge: true,
                color: Colors.yellow,
              ),
              AussiePieChartModel(
                sectionTitle: "no religon",
                value: 70.407,
                color: Colors.purple,
              ),
              AussiePieChartModel(
                sectionTitle: "aboriginal",
                value: 50,
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
