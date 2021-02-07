import 'package:aussie/models/gmap.dart';
import 'package:aussie/models/info/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/gmap_screen.dart';
import 'package:aussie/util/functions.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NaturalParksDetailsScreen extends StatelessWidget {
  final NaturalParkModel model;
  final String heroTag;
  final Color backgroundColor;
  final Color swatchColor;

  const NaturalParksDetailsScreen({
    @required this.model,
    @required this.heroTag,
    @required this.backgroundColor,
    @required this.swatchColor,
  }) : assert(model != null && heroTag != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: swatchColor,
            elevation: 0,
            pinned: true,
            expandedHeight: .4.sh,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.park_name),
              background: model.image_link != ""
                  ? Hero(
                      tag: heroTag,
                      child: buildImage(model.image_link),
                    )
                  : Container(),
            ),
          ),
          SliverToBoxAdapter(
            child: AussieGMap(
              size: Size(double.infinity, .4.sh),
              model: AussieGMapModel(
                latitude: model.latitude,
                longitude: model.longitude,
                title: model.park_name,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final sectionTitle = model.sections[index]["title"];
                final sectionText = model.sections[index]["text"];
                return Card(
                  color: Colors.cyan,
                  shape: const RoundedRectangleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sectionTitle,
                          style: TextStyle(
                            fontSize: 75.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        ExpandText(
                          "   $sectionText",
                          style: TextStyle(fontSize: 45.sp),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: model.sections.length,
            ),
          ),
        ],
      ),
    );
  }
}
