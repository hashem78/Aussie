import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SizedImageTile extends StatelessWidget {
  final String title;

  final String imageUrl;
  final int widthFactor;
  final int heightFactor;

  const SizedImageTile({
    Key key,
    @required this.title,
    @required this.imageUrl,
    this.widthFactor,
    this.heightFactor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthFactor * SizeConfig.blockSizeHorizontal,
      height: heightFactor * SizeConfig.blockSizeVertical,
      child: Material(
        elevation: 5,
        borderRadius: kaussieRadius,
        child: ClipRRect(
          borderRadius: kaussieRadius,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  color: Colors.lightBlueAccent,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                    color: kausBlue.withAlpha(220),
                    width: widthFactor * SizeConfig.blockSizeHorizontal,
                    height: heightFactor / 3 * SizeConfig.blockSizeVertical,
                    child: Center(
                        child: Text(title, style: TextStyle(fontSize: 30)))),
              ),
              Material(
                type: MaterialType.transparency,
                child: InkWell(
                  splashColor: kausRed.withAlpha(150),
                  onTap: () => Navigator.of(context).pushNamed('/'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
