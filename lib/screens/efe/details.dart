import 'package:Aussie/interfaces/geners.dart';
import 'package:Aussie/interfaces/ratings.dart';
import 'package:Aussie/models/efe/efe.dart';

import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:Aussie/widgets/aussie/scrollable_list.dart';
import 'package:Aussie/widgets/sized_tile.dart';
import 'package:Aussie/widgets/social_icons_row.dart';
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
  final Color backgroundColor;
  final double titleImageHeight;
  final T model;
  EFEDetails({
    @required this.model,
    this.backgroundColor = Colors.blue,
    titleImageHeight,
  })  : assert(model != null),
        titleImageHeight = titleImageHeight ?? 200.h;

  @override
  Widget build(BuildContext context) {
    var _titleImgae = buildImage(model.titleImageUrl);
    var _gallery = model.galleryImageLinks.map(
      (e) {
        var _image = buildImage(e.url);
        return SizedTile(
          title: e.title,
          image: _image,
          widthFactor: 100,
          heightFactor: 25,
        );
      },
    ).toList();
    var _descriptions = <ExpandingTextTile>[];
    model.descriptions.forEach((key, value) =>
        _descriptions.add(ExpandingTextTile(title: key, text: value)));

    return Scaffold(
      backgroundColor: backgroundColor,
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
              background: _titleImgae,
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
                AussieScrollableList(
                  title: "Gallery",
                  scrollDirection: Axis.horizontal,
                  heightFactor: 42,
                  childPadding: EdgeInsets.symmetric(horizontal: 1),
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
