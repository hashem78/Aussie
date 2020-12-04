import 'package:aussie/interfaces/geners.dart';
import 'package:aussie/interfaces/ratings.dart';
import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/presentation/widgets/animated/expanded_text_tile.dart';

import 'package:aussie/presentation/widgets/social_icons_row.dart';
import 'package:aussie/util/functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EFEDetails<T extends MainScreenDetailsModel> extends StatelessWidget {
  //final double titleImageHeight;
  final T model;

  final Color backgroundColor;
  final Color swatchColor;
  EFEDetails({
    @required this.model,
    this.backgroundColor,
    this.swatchColor,
  }) : assert(model != null);

  @override
  Widget build(BuildContext context) {
    var _descriptions = <ExpandingTextTile>[];

    model.descriptions.forEach((key, value) => _descriptions.add(
          ExpandingTextTile(
            title: key,
            text: value,
            color: swatchColor,
          ),
        ));

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: .8.sh,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.title),
              background: CarouselSlider.builder(
                itemCount: model.imageLinks.length,
                itemBuilder: (context, index) =>
                    buildImage(model.imageLinks[index], fit: BoxFit.cover),
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                  height: .8.sh,
                  autoPlay: true,
                  autoPlayCurve: Curves.linear,
                  autoPlayInterval: Duration(seconds: 10),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SocialsIconRow(model.socialMediaPlatforms),
                    ..._descriptions,
                    buildGeners(),
                  ],
                ),
                buildRatings(context),
              ],
              addAutomaticKeepAlives: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRatings(BuildContext context) {
    try {
      var casted = model as RatingsInterface;
      return casted.buildRatings(context);
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
