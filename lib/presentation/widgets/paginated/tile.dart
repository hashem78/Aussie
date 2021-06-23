import 'package:aussie/models/themes/color_data_model.dart';
import 'package:flutter/material.dart';

class PaginatedScreenTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? titleImage;
  final void Function()? onTap;
  final double aspectRatio;

  const PaginatedScreenTile({
    required this.title,
    this.subtitle,
    this.onTap,
    this.titleImage,
    this.aspectRatio = 11 / 9,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AussieThemeProvider.of(context)!.color.swatchColor,
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
