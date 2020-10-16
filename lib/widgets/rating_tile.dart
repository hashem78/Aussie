import 'package:Aussie/constants.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingTile extends StatelessWidget {
  final String owner;
  final String reviewText;
  final double rating;
  const RatingTile({
    Key key,
    this.owner,
    this.reviewText,
    this.rating,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: kaussieRadius,
          color: Colors.red.shade600,
          boxShadow: [
            BoxShadow(blurRadius: 10),
          ]),
      child: ListTile(
        title: AnimatedExpandingTextTile(
          title: owner,
          text: reviewText,
          expandedTextColor: Colors.grey,
          color: Colors.transparent,
          titleStyle: TextStyle(fontSize: 30),
          maxLines: 3,
          overflow: TextOverflow.clip,
          showShadow: false,
        ),
        contentPadding: EdgeInsets.zero,
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Rating: "),
            SmoothStarRating(
              rating: rating,
              isReadOnly: false,
              size: 25,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              color: Colors.amber,
              starCount: 5,
              allowHalfRating: true,
              spacing: 2.0,
              onRated: (value) {
                print("rating value -> $value");
              },
            ),
          ],
        ),
      ),
    );
  }
}
