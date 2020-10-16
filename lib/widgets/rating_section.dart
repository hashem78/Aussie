import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/details.dart';
import 'package:Aussie/widgets/rating_tile.dart';
import 'package:flutter/material.dart';

class RatingSection extends StatelessWidget {
  const RatingSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Section(
      children: <Widget>[
        Text(
          "People who've rated this event...",
          //textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        RatingTile(rating: 3, owner: "Jhon Posser", reviewText: klorem),
        RatingTile(rating: 4, owner: "Jhon Posser", reviewText: klorem),
        RatingTile(rating: 5, owner: "Jhon Posser", reviewText: klorem),
      ],
    );
  }
}
