import 'package:flutter/material.dart';

class PaginatedScreenTile extends StatelessWidget {
  final Widget title;
  final Widget subtitle;
  final void Function() onTap;
  const PaginatedScreenTile({
    @required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.5),
      child: ListTile(
        tileColor: Colors.green,
        title: title,
        subtitle: subtitle,
        onTap: onTap,
      ),
    );
  }
}
