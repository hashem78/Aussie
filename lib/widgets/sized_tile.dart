import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/details.dart';
import 'package:Aussie/size_config.dart';

class SizedImageTile extends StatelessWidget {
  final String title;

  final Widget image;
  final int widthFactor;
  final int heightFactor;
  final String tag = UniqueKey().toString();
  final Details detailsScreen;
  final Color swatchColor;

  SizedImageTile({
    @required this.title,
    @required this.image,
    this.widthFactor,
    this.heightFactor,
    swatchColor,
  })  : swatchColor = swatchColor ?? kausBlue.withAlpha(240),
        detailsScreen = null;

  SizedImageTile.withDetails({
    @required this.image,
    @required this.detailsScreen,
    this.title,
    this.widthFactor,
    this.heightFactor,
    swatchColor,
  }) : swatchColor = swatchColor ?? kausBlue.withAlpha(240);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthFactor * SizeConfig.blockSizeHorizontal,
      height: heightFactor * SizeConfig.blockSizeVertical,
      decoration: BoxDecoration(
          // boxShadow: [BoxShadow(offset: Offset(0, 2), blurRadius: 5)],
          //borderRadius: kaussieRadius,
          ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          image,
          SizedTileSwatch(
            widthFactor: widthFactor,
            heightFactor: heightFactor,
            title: title,
            color: swatchColor,
          ),
          if (detailsScreen != null)
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                splashColor: kausRed.withAlpha(120),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => detailsScreen)),
              ),
            ),
        ],
      ),
    );
  }
}

class SizedTileSwatch extends StatelessWidget {
  SizedTileSwatch({
    Key key,
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

  final int widthFactor;
  final int heightFactor;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: color,
          width: widthFactor * SizeConfig.blockSizeHorizontal,
          height: heightFactor / 3 * SizeConfig.blockSizeVertical,
          child: Center(
            child: AutoSizeText(
              title,
              maxLines: 1,
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
