import 'package:aussie/constants.dart';
import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/presentation/screens/main/details.dart';
import 'package:aussie/presentation/widgets/aussie/app_drawer.dart';
import 'package:aussie/presentation/widgets/aussie/scrollable_list.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/presentation/widgets/sized_tile.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget {
  static final title = "Explore";
  static final navPath = "/main";
  static Widget buildTiles(
    List<MainScreenDetailsModel> models, {
    double widthFactor,
    double heightFactor,
    double swatchWidthFactor,
    double swatchHeightFactor,
    double titleImageHeight,
    double listHeightFactor,
    double listScrollOffset,
    Color swatchColor = Colors.transparent,
    Color detailsBackgroundColor,
  }) {
    titleImageHeight = titleImageHeight ?? .5.sh;
    return Builder(
      builder: (BuildContext context) {
        return AussieScrollableList(
          heightFactor: listHeightFactor,
          scrollDirection: Axis.horizontal,
          initalScrollOffset: listScrollOffset,
          children: models.map(
            (model) {
              var _key = UniqueKey().toString();
              return SizedTile.withDetails(
                widthFactor: widthFactor,
                heightFactor: heightFactor,
                swatchWidthFactor: swatchWidthFactor,
                swatchHeightFactor: swatchHeightFactor,
                title: model.title,
                swatchColor: swatchColor,
                image: buildImage(model.titleImageUrl, fit: BoxFit.fill),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => EFEDetails(
                      model: model,
                      tag: _key,
                      titleImageHeight: titleImageHeight,
                      backgroundColor: detailsBackgroundColor,
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      drawer: AussieAppDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [AussieSliverAppBar(kausBlue, "Aussie")],
        ),
      ),
    );
  }
}
