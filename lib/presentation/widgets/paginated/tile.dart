import 'package:flutter/material.dart';

import 'package:aussie/models/themes/color_data_model.dart';

class PaginatedScreenTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? titleImage;
  final void Function()? onTap;
  final double aspectRatio;
  const PaginatedScreenTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.titleImage,
    this.onTap,
    this.aspectRatio = 11 / 9,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AussieThemeProvider.of(context)!.color.swatchColor,
        shape: const RoundedRectangleBorder(),
        child: Column(
          children: <Widget>[
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
