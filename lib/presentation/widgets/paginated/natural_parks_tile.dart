import 'package:aussie/models/paginated/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';
import 'package:aussie/util/functions.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NaturalParksTile extends StatelessWidget {
  final NaturalParkModel model;
  final String heroTag;
  final void Function() onTap;
  const NaturalParksTile({
    @required this.model,
    @required this.heroTag,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return PaginatedScreenTile(
      onTap: onTap,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 7.5),
        child: AutoSizeText(
          model.parkName,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 100.sp, fontWeight: FontWeight.w800),
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Expanded(child: buildChip("Longitude", model.longitude)),
              Expanded(child: buildChip("Latitude", model.latitude)),
            ],
          ),
          Card(
            elevation: 2,
            color: Colors.cyan,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ExpandText(
                model.summary,
                maxLines: 4,
                expandOnGesture: false,
              ),
            ),
          ),
        ],
      ),
      titleImage: model.imageUrl != "" && heroTag != null
          ? Hero(
              tag: heroTag,
              child: buildImage(
                model.imageUrl,
                fit: BoxFit.cover,
                fadeInDuration: Duration.zero,
                showPlaceHolder: true,
              ),
            )
          : buildImage(
              model.imageUrl,
              fit: BoxFit.cover,
              fadeInDuration: Duration.zero,
              showPlaceHolder: true,
            ),
    );
  }

  SizedBox buildChip(String title, String value) {
    return SizedBox(
      height: .08.sh,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        color: Colors.lime,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 65.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                value,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
