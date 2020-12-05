import 'package:aussie/constants.dart';
import 'package:aussie/models/aussie_pie_chart.dart';
import 'package:aussie/presentation/widgets/animated/expanded_text_tile.dart';
import 'package:aussie/presentation/widgets/animated/pie_chart.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/util/functions.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class HEducationScreen extends StatelessWidget {
  static final title = "heTitle";
  static final navPath = "/statistics/heducation";
  static final svgName = "heducation.svg";
  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      backgroundColor: Colors.amber,
      drawer: getAppDrawer(context),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool _) => [
          SliverAppBar(
            primary: true,
            pinned: true,
            backgroundColor: Colors.amber.shade900,
            elevation: 0,
            title: Text(getTranslation(context, HEducationScreen.title)),
          ),
        ],
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ExpandingTextTile(
              text: heducation,
              title: "Higher Edcuation",
              color: Colors.amber.shade900,
            ),
            AutoSizeText(
              "1,609,798 students in total",
              textAlign: TextAlign.center,
              maxLines: 2,
              minFontSize: 30,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildGridView(),
            AspectRatio(
              aspectRatio: 1.4,
              child: AussiePieChart(
                aspectRatio: 1.4,
                sectionRadius: 120,
                chartData: [
                  AussiePieChartModel(
                    color: Colors.red,
                    value: 55.6,
                    sectionTitle: "Female",
                  ),
                  AussiePieChartModel(
                    value: 44.4,
                    color: Colors.blue,
                    sectionTitle: "Male",
                  )
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: .66,
              child: AussiePieChart(
                aspectRatio: 1.12,
                indicatorMargin: EdgeInsets.zero,
                showIndicators: true,
                title: "By field",
                sectionRadius: 150,
                chartData: [
                  AussiePieChartModel(
                    color: getRandomColor(),
                    indicatorText: "Mangement & Commerce",
                    value: 25.1,
                  ),
                  AussiePieChartModel(
                    color: getRandomColor(),
                    indicatorText: "Society & Culture",
                    value: 19.9,
                  ),
                  AussiePieChartModel(
                    color: getRandomColor(),
                    indicatorText: "Health",
                    value: 15.4,
                  ),
                  AussiePieChartModel(
                    color: getRandomColor(),
                    indicatorText: "IT",
                    value: 7.9,
                  ),
                  AussiePieChartModel(
                    color: getRandomColor(),
                    indicatorText: "Education",
                    value: 7.4,
                  ),
                  AussiePieChartModel(
                    indicatorText: "Natural & Physical Sciences",
                    color: getRandomColor(),
                    value: 7.4,
                  ),
                  AussiePieChartModel(
                    color: getRandomColor(),
                    indicatorText: "Creative Arts",
                    value: 6.2,
                  ),
                  AussiePieChartModel(
                    indicatorText: "Engineering",
                    color: getRandomColor(),
                    value: 6.0,
                  ),
                  AussiePieChartModel(
                    color: getRandomColor(),
                    indicatorText: "Architecture & Building",
                    value: 2.4,
                  ),
                  AussiePieChartModel(
                    color: getRandomColor(),
                    indicatorText: "Agriculture & Environment",
                    value: 1.1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GridView buildGridView() {
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .8,
      ),
      children: [
        AussiePieChart(
          showIndicators: true,
          sectionRadius: 80,
          chartData: [
            AussiePieChartModel(
              value: 30.2,
              indicatorText: "Postgrads",
              color: Colors.red,
            ),
            AussiePieChartModel(
              indicatorText: "Undergrads",
              value: 69.8,
              color: Colors.blue,
            ),
          ],
        ),
        AussiePieChart(
          sectionRadius: 80,
          showIndicators: true,
          chartData: [
            AussiePieChartModel(
              value: 32.4,
              indicatorText: "International",
              color: Colors.red,
            ),
            AussiePieChartModel(
              value: 67.6,
              indicatorText: "Domestic",
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}
