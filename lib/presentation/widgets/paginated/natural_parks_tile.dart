import 'package:aussie/models/info/natural_parks/natural_parks.dart';
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
          model.park_name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 100.ssp, fontWeight: FontWeight.w800),
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: buildChip(
                    getTranslation(context, "longitude"), model.longitude),
              ),
              Expanded(
                child: buildChip(
                    getTranslation(context, "latitude"), model.latitude),
              ),
            ],
          ),
          Card(
            elevation: 2,
            color: Colors.cyan,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            shape: const RoundedRectangleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ExpandText(
                model.summary,
                maxLines: 4,
              ),
            ),
          ),
        ],
      ),
      titleImage: model.image_link != "" && heroTag != null
          ? Hero(
              tag: heroTag,
              child: buildImage(
                model.image_link,
                fit: BoxFit.cover,
                fadeIn: Duration.zero,
              ),
            )
          : buildImage(
              model.image_link,
              fit: BoxFit.cover,
              fadeIn: Duration.zero,
            ),
    );
  }

  SizedBox buildChip(String title, String value) {
    return SizedBox(
      height: .08.sh,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        shape: const RoundedRectangleBorder(),
        color: Colors.lime,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 80.ssp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
