import 'package:aussie/constants.dart';
import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/presentation/screens/main/details.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/scrollable_list.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/presentation/widgets/sized_tile.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget {
  static final title = "Home";
  static final navPath = "/main";
  static final String svgName = "home.svg";
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
          children: models.map(
            (model) {
              return SizedTile.withDetails(
                widthFactor: widthFactor,
                heightFactor: heightFactor,
                swatchWidthFactor: swatchWidthFactor,
                swatchHeightFactor: swatchHeightFactor,
                title: model.title,
                swatchColor: swatchColor,
                image: buildImage(model.imageLinks.first, fit: BoxFit.fill),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => EFEDetails(
                      model: model,
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
    return AussieScaffold(
      drawer: getAppDrawer(context),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            AussieSliverAppBar(kausBlue, "Aussie"),
          ],
        ),
      ),
    );
  }
}
