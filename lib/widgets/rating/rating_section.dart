import 'package:Aussie/models/ratings.dart';
import 'package:Aussie/widgets/rating/rating_tile.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/screens/efe/details.dart';

class RatingSection extends StatelessWidget {
  final List<RatingsModel> models;
  final String title;
  final bool readOnly;
  const RatingSection({
    Key key,
    @required this.models,
    @required this.title,
    this.readOnly = false,
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
        ...models
            .map(
              (e) => RatingTile(
                model: e,
                readOnly: readOnly,
              ),
            )
            .toList(),
      ],
    );
  }
}
