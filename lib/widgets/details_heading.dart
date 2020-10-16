import 'package:Aussie/size_config.dart';
import 'package:flutter/material.dart';

class DetailsHeading extends StatelessWidget {
  const DetailsHeading({
    Key key,
    @required this.title,
  }) : super(key: key);

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
          color: Colors.green.shade300,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
