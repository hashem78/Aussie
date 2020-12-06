import 'package:aussie/models/in_aus/main_screen_details.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/presentation/screens/in_aus/details.dart';
import 'package:aussie/presentation/widgets/sized_tile.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

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
                colorData: getColorData(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
