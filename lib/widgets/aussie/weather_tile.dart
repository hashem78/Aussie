import 'package:Aussie/models/weather/weather.dart';
import 'package:Aussie/screens/info/weather/details.dart';
import 'package:Aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherTile extends StatefulWidget {
  final WeatherModel model;

  const WeatherTile({@required this.model});

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
      color: Colors.blue,
      child: Stack(
        children: [
          buildImage(_today.imageUrl),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: BoxedIcon(
                  WeatherIcons.fromString(_today.highIconString),
                  size: iconSize,
                  color: Colors.yellow,
                ),
              ),
              AutoSizeText(
                "It's currently ${_today.highTemp} in ${_today.title}",
                minFontSize: 20.sp,
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                _today.title,
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return WeatherDetails(model: _today);
                }));
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
