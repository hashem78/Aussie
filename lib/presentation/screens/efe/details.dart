import 'package:aussie/interfaces/geners.dart';
import 'package:aussie/interfaces/ratings.dart';
import 'package:aussie/models/efe/efe.dart';
import 'package:aussie/presentation/widgets/animated/expanded_text_tile.dart';
import 'package:aussie/presentation/widgets/aussie/scrollable_list.dart';
import 'package:aussie/presentation/widgets/sized_tile.dart';
import 'package:aussie/presentation/widgets/social_icons_row.dart';

import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Section extends StatelessWidget {
  final List<Widget> children;
  const Section({
    @required List<Widget> children,
  })  : assert(children != null),
        children = children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }
}

class EFEDetails<T extends EFEModel> extends StatelessWidget {
  final double titleImageHeight;
  final T model;
  final String tag;
  EFEDetails({
    @required this.model,
    @required this.tag,
    double titleImageHeight,
  })  : assert(model != null && tag != null),
        titleImageHeight = titleImageHeight ?? 1.sh;

  @override
  Widget build(BuildContext context) {
    var _titleImage = Hero(tag: tag, child: buildImage(model.titleImageUrl));
    var _gallery = model.galleryImageLinks.map(
      (e) {
        var _image = buildImage(e.url);
        return SizedTile(
          title: e.title,
          image: _image,
          widthFactor: .97.sw,
          heightFactor: 25,
          swatchHeightFactor: .06.sh,
          swatchWidthFactor: 1.sw,
        );
      },
    ).toList();
    var _descriptions = <ExpandingTextTile>[];
    model.descriptions.forEach((key, value) =>
        _descriptions.add(ExpandingTextTile(title: key, text: value)));

    return Scaffold(
      backgroundColor: Colors.blue,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            expandedHeight: titleImageHeight,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.title),
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: _titleImage,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Section(
                  children: [
                    SocialsIconRow(model.socialMediaPlatforms),
                    ..._descriptions,
                    buildGeners(),
                  ],
                ),
                buildRatings(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Gallery",
                    style: TextStyle(
                      fontSize: 100.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                AussieScrollableList(
                  scrollDirection: Axis.horizontal,
                  heightFactor: .42.sh,
                  children: _gallery,
                ),
              ],
              addAutomaticKeepAlives: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRatings() {
    try {
      var casted = model as RatingsInterface;
      return casted.buildRatings();
    } catch (e) {
      return Container();
    }
  }

  Widget buildGeners() {
    try {
      var casted = model as GenersInterface;
      return casted.buildGeners();
    } catch (e) {
      return Container();
    }
  }
}