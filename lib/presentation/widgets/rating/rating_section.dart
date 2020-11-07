import 'package:Aussie/models/ratings.dart';
import 'package:Aussie/presentation/screens/efe/details.dart';
import 'package:Aussie/presentation/widgets/rating/rating_tile.dart';

import 'package:flutter/material.dart';

class RatingSection extends StatelessWidget {
  final List<RatingsModel> models;
  final String title = "User reviews";
  final bool readOnly;
  const RatingSection({
    Key key,
    @required this.models,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Section(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
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
      ),
    );
  }
}
