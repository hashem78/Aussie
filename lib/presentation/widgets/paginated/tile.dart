import 'package:flutter/material.dart';

class PaginatedScreenTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final Widget titleImage;
  final void Function() onTap;
  const PaginatedScreenTile({
    @required this.title,
    this.subtitle,
    this.onTap,
    this.titleImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            titleImage != null
                ? AspectRatio(
                    aspectRatio: 16 / 9,
                    child: titleImage,
                  )
                : Container(),
            title,
            subtitle,
          ],
        ),
      ),
    );
  }
}
