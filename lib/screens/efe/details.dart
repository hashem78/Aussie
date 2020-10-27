import 'package:Aussie/interfaces/geners.dart';
import 'package:Aussie/interfaces/ratings.dart';
import 'package:Aussie/models/efe/efe.dart';

import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/animated/banner_image.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';
import 'package:Aussie/widgets/animated/sized_tile.dart';
import 'package:Aussie/widgets/aussie/scrollable_list.dart';
import 'package:Aussie/widgets/details_heading.dart';
import 'package:Aussie/widgets/social_icons_row.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/widgets/aussie/sliver_appbar.dart';

class Section extends StatelessWidget {
  final List<Widget> children;
  final Color borderColor;
  const Section({
    Key key,
    @required List<Widget> children,
    this.borderColor = Colors.grey,
  })  : assert(children != null),
        children = children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

class EFEDetails<T extends EFEModel> extends StatelessWidget {
  final Color backgroundColor;
  final T model;
  const EFEDetails({
    @required this.model,
    this.backgroundColor = Colors.blue,
  }) : assert(model != null);

  @override
  Widget build(BuildContext context) {
    var _titleImgae = buildImage(model.titleImageUrl);
    var _gallery = model.galleryImageLinks.map(
      (e) {
        var _image = buildImage(e.url);
        return AnimatedSizedTile(
          title: e.title,
          image: _image.first,
          widthFactor: 97,
          heightFactor: 30,
        );
      },
    ).toList();
    var _descriptions = <ExpandingTextTile>[];
    model.descriptions.forEach((key, value) =>
        _descriptions.add(ExpandingTextTile(title: key, text: value)));

    return Scaffold(
      backgroundColor: backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          AussieSliverAppBar(
            backgroundColor: backgroundColor,
            title: model.title,
            showHero: false,
            automaticallyImplyLeading: true,
          )
        ],
        body: ListView(
          addAutomaticKeepAlives: true,
          physics: BouncingScrollPhysics(),
          children: [
            AnimatedBannerImage(
              heroTag: _titleImgae.second,
              image: _titleImgae.first,
              heightFactor: 70,
            ),
            Section(
              children: [
                SocialsIconRow(model.socialMediaPlatforms),
                DetailsHeading(title: model.title, color: Colors.white),
                ..._descriptions,
                buildGeners(),
              ],
            ),
            buildRatings(),
            AussieScrollableList(
              title: "Gallery",
              scrollDirection: Axis.horizontal,
              heightFactor: 50,
              childPadding: EdgeInsets.all(5),
              children: _gallery,
            ),
          ],
        ),
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
