import 'package:aussie/models/ratings.dart';
import 'package:aussie/presentation/widgets/animated/expanded_text_tile.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingTile extends StatelessWidget {
  final bool readOnly;
  final Color color;
  final RatingsModel model;
  const RatingTile({
    @required this.model,
    this.readOnly = false,
    color,
  })  : assert(readOnly != null),
        color = color ?? Colors.red;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      color: color,
      child: ListTile(
        title: ExpandingTextTile(
          title: model.commentOwner,
          text: model.reviewText,
          expandedTextColor: Colors.grey.shade300,
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
              rating: model.rating,
              isReadOnly: readOnly,
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
