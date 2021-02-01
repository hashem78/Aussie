import 'package:aussie/models/info/species/species.dart';
import 'package:aussie/models/themes/color_data.dart';
import 'package:aussie/presentation/widgets/animated/expanded_text_tile.dart';
import 'package:aussie/util/functions.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeciesDetails extends StatelessWidget {
  final SpeciesDetailsModel model;

  const SpeciesDetails({
    @required this.model,
  }) : assert(
          model != null,
          "A Species descriptions' model cannot be null",
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AussieThemeProvider.of(context).color.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AussieThemeProvider.of(context).color.swatchColor,
            elevation: 0,
            expandedHeight: .5.sh,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.commonName),
              background: model.titleImageUrl != null && model.imageUrls == null
                  ? buildImage(model.titleImageUrl)
                  : CarouselSlider.builder(
                      itemCount: model.imageUrls.length,
                      itemBuilder: (context, index, realIndex) => buildImage(
                        model.imageUrls[index],
                        showPlaceHolder: false,
                        fadeIn: Duration.zero,
                        fit: BoxFit.cover,
                      ),
                      options: CarouselOptions(
                        height: .5.sh,
                        viewportFraction: 1,
                        pageSnapping: false,
                        autoPlay: true,
                        enableInfiniteScroll:
                            model.imageUrls.length == 1 ? false : true,
                        autoPlayInterval: const Duration(seconds: 10),
                      ),
                    ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildDataTable(),
                ExpandingTextTile(
                  text: model.description,
                  title: "Info",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataTable buildDataTable() => DataTable(
        dataTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        columnSpacing: 3,
        headingRowHeight: 0,
        columns: [
          DataColumn(label: Container()),
          DataColumn(label: Container()),
        ],
        //headingRowHeight: 0,
        rows: [
          if (model.commonName != null && model.commonName != "")
            DataRow(
              cells: [
                const DataCell(
                  Text(
                    "Common name",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                DataCell(Text(model.commonName)),
              ],
            ),
          DataRow(
            cells: [
              const DataCell(
                Text(
                  "Scientific name",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              DataCell(Text(model.scientificName)),
            ],
          ),
          if (model.type != null)
            DataRow(
              cells: [
                const DataCell(
                  Text(
                    "Type",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                DataCell(Text(model.type)),
              ],
            ),
          if (model.conservationStatus != null)
            DataRow(
              cells: [
                const DataCell(
                  Text(
                    "Conservation status",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                DataCell(Text(model.conservationStatus)),
              ],
            ),
        ],
      );
}
