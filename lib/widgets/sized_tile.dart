import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/size_config.dart';

class SizedTile extends StatelessWidget {
  final String title;

  final Widget image;
  final int widthFactor;
  final int heightFactor;
  final String tag = UniqueKey().toString();
  final Widget child;
  final Color swatchColor;
  final swatchMaxLines;

  SizedTile({
    Key key,
    @required this.title,
    @required this.image,
    this.widthFactor,
    this.heightFactor,
    Color swatchColor,
    this.swatchMaxLines = 1,
  })  : swatchColor = swatchColor ?? kausBlue.withAlpha(240),
        child = null;

  SizedTile.withDetails({
    @required this.image,
    @required this.child,
    this.title,
    this.widthFactor,
    this.heightFactor,
    swatchColor,
    this.swatchMaxLines = 1,
  }) : swatchColor = swatchColor ?? kausBlue.withAlpha(240);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthFactor * SizeConfig.blockSizeHorizontal,
      height: heightFactor * SizeConfig.blockSizeVertical,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(offset: Offset(0, 2), blurRadius: 5)],
        borderRadius: kaussieRadius,
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          image,
          SizedTileSwatch(
            maxLines: swatchMaxLines,
            widthFactor: widthFactor,
            heightFactor: heightFactor,
            title: title,
            color: swatchColor,
          ),
          if (child != null)
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: kausRed.withAlpha(120),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => child)),
              ),
            ),
        ],
      ),
    );
  }
}

class SizedTileSwatch extends StatelessWidget {
  final int maxLines;
  final int widthFactor;
  final int heightFactor;
  final String title;
  final Color color;

  SizedTileSwatch({
    Key key,
    this.maxLines = 1,
    @required this.widthFactor,
    @required this.heightFactor,
    @required this.title,
    this.color,
  })  : assert(
          color != null &&
              widthFactor != null &&
              heightFactor != null &&
              title != null,
          "One of the properties of a swatch were set incorrectly",
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: color,
        width: widthFactor * SizeConfig.blockSizeHorizontal,
        height: heightFactor / 4 * SizeConfig.blockSizeVertical,
        child: Center(
          child: AutoSizeText(
            title,
            maxLines: maxLines,
            minFontSize: 15,
            textScaleFactor: 1.2,
          ),
        ),
      ),
    );
  }
}
