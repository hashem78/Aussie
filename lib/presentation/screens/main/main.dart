import 'package:aussie/constants.dart';
import 'package:aussie/models/main_screen/main_screen_details.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/presentation/screens/main/details.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/presentation/widgets/aussie/sliver_appbar.dart';

import 'package:aussie/presentation/widgets/sized_tile.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static final title = "Home";
  static final navPath = "/main";
  static final String svgName = "home.svg";

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

class AussieTileList extends StatelessWidget {
  final double widthFactor;
  final double heightFactor;
  final double swatchWidthFactor;
  final double swatchHeightFactor;
  final double titleImageHeight;
  final double listHeightFactor;
  final double listScrollOffset;
  final AussieColorData detailsColorData;
  final List<MainScreenDetailsModel> models;

  const AussieTileList({
    this.models,
    this.widthFactor,
    this.heightFactor,
    this.swatchWidthFactor,
    this.swatchHeightFactor,
    this.titleImageHeight,
    this.listHeightFactor,
    this.listScrollOffset,
    this.detailsColorData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeightFactor,
      child: ListView.builder(
        addAutomaticKeepAlives: true,
        scrollDirection: Axis.horizontal,
        itemCount: models.length,
        itemBuilder: (BuildContext context, int index) => SizedTile.withDetails(
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          swatchWidthFactor: swatchWidthFactor,
          swatchHeightFactor: swatchHeightFactor,
          title: models[index].title,
          swatchColor: detailsColorData.swatchColor,
          image: buildImage(models[index].imageLinks.first, fit: BoxFit.fill),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => EFEDetails(
                model: models[index],
                colorData: Provider.of<AussieColorData>(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
