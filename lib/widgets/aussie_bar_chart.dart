import 'package:Aussie/constants.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AussieBarChart extends StatelessWidget {
  const AussieBarChart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: .63,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        color: const Color(0xff81e5cd),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    AutoSizeText(
                      'Muslim population in Australlia',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      minFontSize: 30,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 38,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: buildChart(),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AnimatedExpandingTextTile(text: klorem, title: "gg"),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildChart() => BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return "1981";
                case 1:
                  return "1991";
                case 2:
                  return "2001";
                case 3:
                  return "2011";
                case 4:
                  return "2016";
                default:
                  return "";
              }
            },
            getTextStyles: (value) => const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        barGroups: [
          buildAussieChartGroupData(0, 76792),
          buildAussieChartGroupData(1, 147487),
          buildAussieChartGroupData(2, 281600),
          buildAussieChartGroupData(3, 476291),
          buildAussieChartGroupData(4, 604200),
        ],
      ),
    );
BarChartGroupData buildAussieChartGroupData(int x, double y) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        width: 22,
        y: y,
        borderRadius: BorderRadius.zero,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: 1e6,
          colors: [Colors.grey.shade300],
        ),
      ),
    ],
  );
}
