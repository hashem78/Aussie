import 'package:aussie/state/paginated/cubit/aussiepaginated_cubit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/models/gmap.dart';
import 'package:aussie/models/paginated/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/gmap_screen.dart';
import 'package:aussie/presentation/screens/searchable_paginated.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';
import 'package:aussie/util/functions.dart';

class NaturalParksScreen extends StatelessWidget {
  static String navPath = "/main/info/naturalParks";
  static String svgName = "parks.svg";
  static String title = "Natural Parks";
  final AussiePaginatedCubit<NaturalParkModel> cubit =
      AussiePaginatedCubit("naturalParks");
  @override
  Widget build(BuildContext context) {
    return SearchablePaginatedScreen(
      cubit: cubit,
      title: title,
      filterFor: "park_name",
      thumbnailCubitRoute: "park_images",
      itemBuilder: (context, item, index) {
        var _casted = item as NaturalParkModel;
        var _key = UniqueKey();
        return NaturalParksTile(
          heroTag: _key.toString(),
          model: _casted,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return NaturalParksDetailsScreen(
                  heroTag: _key.toString(),
                  model: _casted,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

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
        color: Colors.blue,
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

class NaturalParksDetailsScreen extends StatelessWidget {
  final NaturalParkModel model;
  final String heroTag;
  const NaturalParksDetailsScreen({
    @required this.model,
    @required this.heroTag,
  }) : assert(model != null && heroTag != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            elevation: 0,
            expandedHeight: .4.sh,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.parkName),
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
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
