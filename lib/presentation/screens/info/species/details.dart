import 'package:aussie/models/info/species/species_model.dart';
import 'package:aussie/models/themes/color_data_model.dart';
import 'package:aussie/presentation/widgets/aussie/aussie_photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    final bool condition =
        model.titleImageUrl != null && model.imageUrls == null;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AussieThemeProvider.of(context).color.backgroundColor,
        appBar: AppBar(
          backgroundColor: AussieThemeProvider.of(context).color.swatchColor,
          elevation: 0,
          title: Text(model.commonName),
          bottom: const TabBar(
            tabs: [
              Icon(Icons.info),
              Icon(Icons.image),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildDataTable(),
                  Text(
                    model.description.trim(),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!condition && model.imageUrls.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text('There are no images available'),
                    ),
                  ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: !condition ? model.imageUrls.length : 1,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return AussiePhotoView(
                                url: !condition
                                    ? model.imageUrls[index]
                                    : model.titleImageUrl,
                              );
                            },
                          ));
                        },
                        child: Ink.image(
                          padding: EdgeInsets.zero,
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            !condition
                                ? model.imageUrls[index]
                                : model.titleImageUrl,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
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
