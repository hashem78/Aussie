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

  SizedImageTile({
    @required this.title,
    @required this.image,
    this.widthFactor,
    this.heightFactor,
  }) : detailsScreen = null;

  SizedImageTile.withDetails({
    @required this.image,
    @required this.detailsScreen,
    this.title,
    this.widthFactor,
    this.heightFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthFactor * SizeConfig.blockSizeHorizontal,
      height: heightFactor * SizeConfig.blockSizeVertical,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(offset: Offset(0, 2), blurRadius: 5)],
        borderRadius: kaussieRadius,
      ),
      child: ClipRRect(
        borderRadius: kaussieRadius,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            image,
            SizedTileSwatch(
              widthFactor: widthFactor,
              heightFactor: heightFactor,
              title: title,
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
      ),
    );
  }
}

class SizedTileSwatch extends StatelessWidget {
  const SizedTileSwatch({
    Key key,
    @required this.widthFactor,
    @required this.heightFactor,
    @required this.title,
  }) : super(key: key);

  final int widthFactor;
  final int heightFactor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: kausBlue.withAlpha(150),
          width: widthFactor * SizeConfig.blockSizeHorizontal,
          height: heightFactor / 3 * SizeConfig.blockSizeVertical,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
