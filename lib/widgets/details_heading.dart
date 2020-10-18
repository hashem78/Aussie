import 'package:flutter/material.dart';

import 'package:Aussie/size_config.dart';

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
    SizeConfig().init(context);
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Text(
        title,
        textAlign: TextAlign.center,
        textScaleFactor: SizeConfig.blockSizeVertical,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
