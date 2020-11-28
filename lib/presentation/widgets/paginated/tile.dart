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
    this.aspectRatio = 16 / 9,
  }) : assert(title != null && aspectRatio != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            titleImage != null
                ? AspectRatio(
                    aspectRatio: aspectRatio,
                    child: titleImage,
                  )
                : Container(),
            title,
            subtitle ?? Container(),
          ],
        ),
      ),
    );
  }
}
