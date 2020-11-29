import 'package:aussie/models/gmap.dart';
import 'package:aussie/models/paginated/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/gmap_screen.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/util/functions.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NaturalParksDetailsScreen extends StatelessWidget {
  final NaturalParkModel model;
  final String heroTag;
  final Color backgroundColor;

  const NaturalParksDetailsScreen({
    @required this.model,
    @required this.heroTag,
    @required this.backgroundColor,
  }) : assert(model != null && heroTag != null);

  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            expandedHeight: .4.sh,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.parkName),
              background: model.imageUrl != ""
                  ? Hero(
                      tag: heroTag,
                      child: buildImage(model.imageUrl),
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
                title: model.parkName,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                var sectionTitle = model.sections[index]["title"];
                var sectionText = model.sections[index]["text"];
                return Card(
                  color: Colors.cyan,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
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
                          style: TextStyle(
                            fontSize: 45.sp,
                          ),
                          maxLines: 5,
                          expandOnGesture: false,
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
