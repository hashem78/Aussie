import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsHeading extends StatelessWidget {
  final Color color;
  DetailsHeading({
    Key key,
    color,
    @required this.title,
  })  : color = color ?? Colors.green.shade300,
        super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(360, 640),
      allowFontScaling: true,
    );
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
