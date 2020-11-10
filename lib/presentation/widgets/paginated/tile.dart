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
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.5),
      child: Column(
        children: [
          titleImage != null
              ? AspectRatio(
                  aspectRatio: 16 / 9,
                  child: titleImage,
                )
              : Container(),
          ListTile(
            tileColor: Colors.green,
            title: title,
            subtitle: subtitle,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
