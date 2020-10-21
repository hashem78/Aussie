import 'dart:math';

import 'package:Aussie/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'animated/expanded_text_tile.dart';

class AussieBarChart extends StatelessWidget {
  //final Color color = const Color(0xff81e5cd);
  final Color color;
  final Color rodBackgroundColor;
  final List<Widget> infoWidgets;
  final List<AussieBarChartModel> chartData;
  final double barChartRodWidth;
  AussieBarChart({
    this.barChartRodWidth = 22,
    this.color = Colors.amber,
    rodBackgroundColor,
    infoWidgets,
    chartData,
  })  : assert(barChartRodWidth != null),
        rodBackgroundColor = rodBackgroundColor ?? Colors.grey.shade300,
        chartData = chartData ?? [],
        infoWidgets = infoWidgets ?? [];
  @override
  Widget build(BuildContext context) {
    var infoWidgets = [
      AnimatedExpandingTextTile(
        text: klorem,
        title: "gg",
        color: Colors.black,
      )
    ];
    var charData = [
      AussieBarChartModel(76792.0, "1981"),
      AussieBarChartModel(147487.0, "1991"),
      AussieBarChartModel(281600.0, "2001"),
      AussieBarChartModel(476291.0, "2011"),
      AussieBarChartModel(604200.0, "2016"),
      AussieBarChartModel(704200.0, "2018"),
    ];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: .92,
            child: Container(
              padding: EdgeInsets.all(8),
              color: color,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
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
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: buildChart(charData),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ...infoWidgets
              .map(
                (e) => Container(
                  color: color,
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child: e,
                ),
              )
              .toList(),
        ],
      ),
    );
  }

  BarChart buildChart(List<AussieBarChartModel> chartData) => BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
            topTitles: SideTitles(showTitles: false),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (double value) => chartData[value.toInt()].title,
              getTextStyles: (value) => const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          barGroups: buildAussieChartGroupData(chartData),
        ),
      );
  List<BarChartGroupData> buildAussieChartGroupData(
      List<AussieBarChartModel> data) {
    double mx = 0;
    List<BarChartGroupData> res = [];
    for (int i = 0; i < data.length; ++i) mx = data[i].y > mx ? data[i].y : mx;
    for (int i = 0; i < data.length; ++i) {
      res.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              width: barChartRodWidth,
              y: data[i].y,
              borderRadius: BorderRadius.zero,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                y: pow(10, (log(mx) / ln10 + 1).truncateToDouble()),
                colors: [rodBackgroundColor],
              ),
            ),
          ],
        ),
      );
    }
    return res;
  }
}

class AussieBarChartModel {
  final double y;
  final String title;

  AussieBarChartModel(this.y, this.title);
}
