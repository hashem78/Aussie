import 'package:flutter/material.dart';

import 'package:Aussie/screens/details.dart';

class RatingSection extends StatelessWidget {
  final List<Widget> children;
  final String title;
  const RatingSection({
    Key key,
    @required this.children,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        ...children,
      ],
    );
  }
}
