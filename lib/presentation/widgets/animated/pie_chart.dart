import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/models/aussie_pie_chart.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  final double size;
  final Color textColor;
  final EdgeInsets indicatorMargin;

  const Indicator({
    this.color,
    this.text,
    this.size = 16,
    this.textColor = const Color(0xff505050),
    EdgeInsets indicatorMargin,
  }) : indicatorMargin = indicatorMargin ?? const EdgeInsets.only(left: 20);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          margin: indicatorMargin,
          width: size.w,
          height: size.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class AussiePieChart extends StatefulWidget {
  final List<AussiePieChartModel> chartData;

  final void Function(int page) onBarTapped;
  final double aspectRatio;
  final String title;
  final double sectionRadius;
  final double titleOffset;
  final EdgeInsets indicatorMargin;

  final bool showIndicators;
  const AussiePieChart({
    @required this.chartData,
    this.onBarTapped,
    this.aspectRatio = 1.05,
    this.sectionRadius = 180,
    this.title,
    this.titleOffset = .6,
    this.showIndicators = false,
    this.indicatorMargin = const EdgeInsets.only(left: 20),
  })  : assert(chartData != null),
        assert(showIndicators == null || (indicatorMargin != null));

  @override
  _AussiePieChartState createState() => _AussiePieChartState();
}

class _AussiePieChartState extends State<AussiePieChart>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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
      child: widget.showIndicators
          ? Expanded(
              child: Center(
                child: ListView.builder(
                  itemCount: widget.chartData.length,
                  physics: BouncingScrollPhysics(),
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var sectionData = widget.chartData[index];
                    if (sectionData.indicatorText != null) {
                      return Indicator(
                        indicatorMargin: EdgeInsets.zero,
                        text: sectionData.indicatorText,
                        color: sectionData.color,
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            )
          : Container(),
      builder: (BuildContext context, Widget child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.title != null)
              AutoSizeText(
                widget.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                minFontSize: 20,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            AspectRatio(
              aspectRatio: widget.aspectRatio,
              child: buildPieChart(),
            ),
            child,
          ],
        );
      },
    );
  }

  PieChart buildPieChart() {
    return PieChart(
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
        centerSpaceRadius: 0,
        sections: List<PieChartSectionData>.generate(
          widget.chartData.length,
          (index) {
            double _size = 40;
            double _pos = .93;
            double _rad = widget.sectionRadius;
            double _titleOffset = widget.titleOffset;
            AussiePieChartModel model = widget.chartData[index];
            double _animVal = model.value;
            String _name = model.sectionTitle ?? model.value.toString();
            bool _badge = model.hasBadge;
            Color _col = model.color;
            if (touchedIndex == index) {
              _size += 5;
              _rad += 5;
            }
            return PieChartSectionData(
              radius: _rad,
              value: _animVal * (_animVal == mx ? _animation1.value : 1),
              title: _name,
              color: _col,
              titlePositionPercentageOffset: _titleOffset,
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
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
