import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class PaginatedScreenTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget titleImage;
  final void Function() onTap;
  final double aspectRatio;
  final Color color;
  const PaginatedScreenTile({
    @required this.title,
    this.subtitle,
    this.onTap,
    this.titleImage,
    this.color,
    this.aspectRatio = 11 / 9,
  }) : assert(title != null && aspectRatio != null);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: getColorData(context).swatchColor,
        shape: const RoundedRectangleBorder(),
        child: Column(
          children: [
            if (titleImage != null)
              AspectRatio(
                aspectRatio: aspectRatio,
                child: titleImage,
              )
            else
              Container(),
            title,
            subtitle ?? Container(),
          ],
        ),
      ),
    );
  }
}
