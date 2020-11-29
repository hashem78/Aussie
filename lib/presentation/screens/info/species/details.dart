import 'package:aussie/models/paginated/species/species.dart';
import 'package:aussie/presentation/widgets/animated/expanded_text_tile.dart';
import 'package:aussie/presentation/widgets/aussie/a_scaffold.dart';
import 'package:aussie/util/functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeciesDetails extends StatelessWidget {
  final SpeciesDetailsModel model;
  final Color detailsBackgroundColor;
  const SpeciesDetails({
    @required this.model,
    @required this.detailsBackgroundColor,
  }) : assert(
          model != null,
          "A Species descriptions' model cannot be null",
        );

  @override
  Widget build(BuildContext context) {
    return AussieScaffold(
      backgroundColor: detailsBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            stretch: true,
            expandedHeight: .5.sh,
            stretchTriggerOffset: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.commonName),
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: buildImage(model.titleImageUrl),
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
        dataTextStyle: TextStyle(fontWeight: FontWeight.bold),
        columnSpacing: 3,
        headingRowHeight: 0,
        columns: [
          DataColumn(label: Container()),
          DataColumn(label: Container()),
        ],
        //headingRowHeight: 0,
        rows: [
          DataRow(
            cells: [
              DataCell(
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
              DataCell(
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
          DataRow(
            cells: [
              DataCell(
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
                DataCell(
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
