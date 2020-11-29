import 'package:aussie/constants.dart';
import 'package:aussie/presentation/widgets/animated/expanded_text_tile.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';

import 'package:aussie/presentation/widgets/aussie/bar_chart.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class LivestockScreen extends StatelessWidget {
  static final title = "Livestock in Australlia";
  static final navPath = "/statistics/livestocks";
  static final svgName = "livestock.svg";
  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      drawer: getAppDrawer(context),
      backgroundColor: Colors.amber,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool _) => [
          SliverAppBar(
            backgroundColor: Colors.amber,
            title: Text("Livestock"),
            centerTitle: true,
          ),
        ],
        body: ListView(
          addAutomaticKeepAlives: true,
          children: [
            ExpandingTextTile(
              title: "The livestock and meat industry",
              text: klorem,
            ),
            ExpandingTextTile(
              text: klorem,
              title: "CN30",
            ),
            AussieBarChart(
              title:
                  "Avg. Australlian beef and veal production('000 tonnes cwt)",
              chartData: [
                AussieBarChartModel(2000, "2000-2011"),
                AussieBarChartModel(2200, "2012"),
                AussieBarChartModel(2400, "2013"),
                AussieBarChartModel(2550, "2014"),
                AussieBarChartModel(2500, "2015"),
                AussieBarChartModel(2200, "2016-2017"),
                AussieBarChartModel(2350, "2016-2017"),
              ],
            ),
            AussieBarChart(
              title:
                  "Avg. Australlian top five beef export markets ('000 tonnes swt)",
              chartData: [
                AussieBarChartModel(325, "China"),
                AussieBarChartModel(280, "Japan"),
                AussieBarChartModel(250, "United States"),
                AussieBarChartModel(160, "South Korea"),
                AussieBarChartModel(50, "Indonesia"),
              ],
              // do the rest for sheep and whatever
            ),
          ],
        ),
      ),
    );
  }
}
