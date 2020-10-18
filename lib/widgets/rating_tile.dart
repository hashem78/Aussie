import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:Aussie/widgets/animated/expanded_text_tile.dart';

class RatingTile extends StatelessWidget {
  final String owner;
  final String reviewText;
  final double rating;
  final bool isReadOnly;
  final Color color;
  RatingTile({
    @required this.owner,
    @required this.reviewText,
    @required this.rating,
    this.isReadOnly = false,
    color,
  })  : assert(isReadOnly != null),
        color = color ?? Colors.red.shade600;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        //borderRadius: kaussieRadius,
        color: color,
        //boxShadow: [BoxShadow(blurRadius: 10)],
      ),
      child: ListTile(
        title: AnimatedExpandingTextTile(
          title: owner,
          text: reviewText,
          expandedTextColor: Colors.grey.shade800,
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
              isReadOnly: isReadOnly,
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
