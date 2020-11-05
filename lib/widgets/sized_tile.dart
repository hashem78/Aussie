import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizedTile extends StatelessWidget {
  final String title;

  final Widget image;
  final double widthFactor;
  final double heightFactor;
  final double swatchHeightFactor;
  final double swatchWidthFactor;
  final String tag = UniqueKey().toString();

  final Color swatchColor;
  final void Function() onTap;
  final swatchMaxLines;

  SizedTile({
    Key key,
    @required this.title,
    @required this.image,
    this.widthFactor,
    this.heightFactor,
    Color swatchColor,
    this.swatchMaxLines = 1,
    this.swatchHeightFactor = 40,
    this.swatchWidthFactor = 100,
  })  : assert(
          image != null &&
              title != null &&
              heightFactor != null &&
              widthFactor != null &&
              swatchHeightFactor != null &&
              swatchWidthFactor != null,
          "A property of a sized tile is set null",
        ),
        swatchColor = swatchColor ?? kausBlue.withAlpha(240),
        onTap = null;

  SizedTile.withDetails({
    @required this.image,
    @required this.onTap,
    @required this.title,
    @required this.widthFactor,
    @required this.heightFactor,
    swatchColor,
    this.swatchMaxLines = 1,
    swatchHeightFactor,
    swatchWidthFactor,
  })  : swatchColor = swatchColor ?? kausBlue.withAlpha(240),
        swatchWidthFactor = swatchWidthFactor ?? 1.sw,
        swatchHeightFactor = swatchHeightFactor ?? .4.sh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthFactor,
      height: heightFactor,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            image,
            SizedTileSwatch(
              maxLines: swatchMaxLines,
              widthFactor: swatchWidthFactor,
              heightFactor: swatchHeightFactor,
              title: title,
              color: swatchColor,
            ),
            if (onTap != null)
              Material(
                type: MaterialType.transparency,
                child: InkWell(
                  splashColor: kausRed.withAlpha(120),
                  onTap: onTap,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SizedTileSwatch extends StatelessWidget {
  final int maxLines;
  final double widthFactor;
  final double heightFactor;
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
        width: widthFactor,
        height: heightFactor,
        child: Center(
          child: AutoSizeText(
            title,
            maxLines: maxLines,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 60.ssp),
          ),
        ),
      ),
    );
  }
}
