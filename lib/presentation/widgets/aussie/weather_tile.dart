import 'package:aussie/models/weather/weather.dart';
import 'package:aussie/presentation/screens/info/weather/details.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherTile extends StatefulWidget {
  final WeatherModel model;
  final bool showTitle;

  const WeatherTile({@required this.model, this.showTitle = false});

  @override
  _WeatherTileState createState() => _WeatherTileState();
}

class _WeatherTileState extends State<WeatherTile> {
  final double _defaultMargin = 2.5;
  final double _defaultIconSize = 60;
  double margin;
  double iconSize;
  @override
  void initState() {
    super.initState();
    margin = _defaultMargin;
    iconSize = _defaultIconSize;
  }

  @override
  Widget build(BuildContext context) {
    var _today = widget.model;

    return AnimatedContainer(
      margin: EdgeInsets.all(margin),
      duration: Duration(milliseconds: 200),
      color: Colors.blue.shade700,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  widget.showTitle ? _today.title : _today.day,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 100.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: BoxedIcon(
                    WeatherIcons.fromString(widget.model.iconString),
                    size: 200.sp,
                    color: Colors.amber,
                  ),
                ),
                AutoSizeText(
                  "${_today.highTemp}°C",
                  softWrap: true,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50.sp,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return WeatherDetails(model: _today);
                    },
                  ),
                );
              },
              onLongPress: () {
                setState(
                  () {
                    margin = 3 * _defaultMargin;
                    iconSize = _defaultIconSize / 1.2;
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => WeatherDetails(
                          model: _today,
                        ),
                      ),
                    )
                        .whenComplete(
                      () {
                        setState(
                          () {
                            margin = _defaultMargin;
                            iconSize = _defaultIconSize;
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
