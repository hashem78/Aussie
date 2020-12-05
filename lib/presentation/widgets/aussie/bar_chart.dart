import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AussieBarChart extends StatefulWidget {
  final String title;
  final Color rodBackgroundColor;
  final List<AussieBarChartModel> chartData;
  final double barChartRodWidth;
  AussieBarChart({
    Color rodBackgroundColor,
    @required this.title,
    @required this.chartData,
    this.barChartRodWidth = 22,
  })  : assert(
          barChartRodWidth != null && chartData != null && title != null,
          "One or more of a bar chart's members is set to null",
        ),
        rodBackgroundColor = rodBackgroundColor ?? Colors.grey.shade300;

  @override
  _AussieBarChartState createState() => _AussieBarChartState();
}

class _AussieBarChartState extends State<AussieBarChart>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController animationController;
  Animation<double> animation;
  double _mx = 0;
  double _val = 0;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..forward();
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );

    widget.chartData.forEach((e) => _mx = e.y > _mx ? e.y : _mx);
    _val = pow(10, log(_mx) / ln10);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoSizeText(
          widget.title,
          textAlign: TextAlign.center,
          maxLines: 3,
          minFontSize: 20,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.0 * widget.chartData.length,
          ),
          child: AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: BarChart(
                  BarChartData(
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      show: true,
                      leftTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        rotateAngle: 45,
                        showTitles: true,
                        getTitles: (double value) =>
                            widget.chartData[value.toInt()].title,
                        getTextStyles: (value) => const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    barGroups: buildAussieChartGroupData(animation.value),
                  ),
                  swapAnimationDuration: Duration(milliseconds: 300),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  List<BarChartGroupData> buildAussieChartGroupData(double factor) {
    List<BarChartGroupData> res = [];
    for (int i = 0; i < widget.chartData.length; ++i) {
      res.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              width: widget.barChartRodWidth,
              y: widget.chartData[i].y * factor,
              borderRadius: BorderRadius.zero,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                y: _val,
                colors: [widget.rodBackgroundColor],
              ),
            ),
          ],
        ),
      );
    }
    return res;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

class AussieBarChartModel {
  final double y;
  final String title;

  AussieBarChartModel(this.y, this.title);
}
