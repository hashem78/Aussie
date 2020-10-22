import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:Aussie/models/animated_pie_chart.dart';

class AnimatedPieChart extends StatefulWidget {
  final List<AnimatedPieChartModel> chartData;
  //final PageController controller;
  final Function(int page) onBarTapped;
  final double aspectRatio;
  const AnimatedPieChart({
    Key key,
    @required this.chartData,
    this.onBarTapped,
    @required this.aspectRatio,
  })  : assert(chartData != null && aspectRatio != 0),
        super(key: key);
  @override
  _AnimatedPieChartState createState() => _AnimatedPieChartState();
}

class _AnimatedPieChartState extends State<AnimatedPieChart>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController _controller;
  Animation<double> _animation1;

  int touchedIndex;
  double mx = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700))
          ..forward();
    _animation1 = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    var chartData = widget.chartData;
    for (int i = 0; i < chartData.length; ++i)
      mx = chartData[i].value > mx ? chartData[i].value : mx;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: _animation1,
      builder: (BuildContext context, Widget child) {
        return AspectRatio(
          aspectRatio: widget.aspectRatio,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (PieTouchResponse response) {
                  setState(
                    () {
                      if (response.touchInput is FlPanEnd ||
                          response.touchInput is FlLongPressEnd) {
                        if (touchedIndex != null && widget.onBarTapped != null)
                          widget.onBarTapped(touchedIndex);

                        touchedIndex = -1;
                      } else {
                        touchedIndex = response.touchedSectionIndex;
                      }
                    },
                  );
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              sections: List<PieChartSectionData>.generate(
                widget.chartData.length,
                (index) {
                  double _size = 40;
                  double _pos = .93;
                  double _rad = 180;
                  double _animVal = widget.chartData[index].value;
                  String _name = widget.chartData[index].name;
                  bool _badge = widget.chartData[index].hasBadge;
                  Color _col = widget.chartData[index].color;
                  if (touchedIndex == index) {
                    _size += 10;
                    _rad += 10;
                  }
                  return PieChartSectionData(
                    radius: _rad,
                    value: _animVal * (_animVal == mx ? _animation1.value : 1),
                    title: _name,
                    color: _col,
                    titlePositionPercentageOffset: .6,
                    badgePositionPercentageOffset: _pos,
                    badgeWidget: _badge
                        ? BadgeWidget(
                            size: _size,
                            assetName: _name,
                          )
                        : null,
                  );
                },
              ),
            ),
            swapAnimationDuration: Duration(milliseconds: 300),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;
}

class BadgeWidget extends StatelessWidget {
  final double size;
  final Color color;
  final Color borderColor;
  final String assetName;

  const BadgeWidget({
    @required double size,
    this.color = Colors.black,
    this.borderColor = Colors.white,
    @required this.assetName,
  })  : assert(
          color != null &&
              borderColor != null &&
              assetName != null &&
              size != null,
          "A badge item is missing one of it's dependencies",
        ),
        size = size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(.8),
        border: Border.all(width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      width: size,
      height: size,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assests/images/$assetName.svg',
            color: color,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
