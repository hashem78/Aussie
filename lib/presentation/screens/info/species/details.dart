import 'package:aussie/aussie_imports.dart';

class SpeciesDetails extends StatelessWidget {
  final SpeciesDetailsModel model;
  const SpeciesDetails({
    Key? key,
    required this.model,
  }) : super(key: key);

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
          title: Text(model.commonName!),
          bottom: const TabBar(
            tabs: <Icon>[
              Icon(Icons.info),
              Icon(Icons.image),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildDataTable(context),
                  Text(
                    model.description!.trim(),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!condition && model.imageUrls!.isEmpty)
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
                    itemCount: !condition ? model.imageUrls!.length : 1,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<AussiePhotoView>(
                              builder: (BuildContext context) {
                                return AussiePhotoView(
                                  url: !condition
                                      ? model.imageUrls![index]
                                      : model.titleImageUrl,
                                );
                              },
                            ),
                          );
                        },
                        child: Ink.image(
                          padding: EdgeInsets.zero,
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            !condition
                                ? model.imageUrls![index]
                                : model.titleImageUrl!,
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

  DataTable buildDataTable(BuildContext context) => DataTable(
        dataTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        columnSpacing: 3,
        headingRowHeight: 0,
        columns: <DataColumn>[
          DataColumn(label: Container()),
          DataColumn(label: Container()),
        ],
        //headingRowHeight: 0,
        rows: <DataRow>[
          if (model.commonName != null && model.commonName != '')
            DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(
                    getTranslation(context, 'speciesCommonName'),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                DataCell(Text(model.commonName!)),
              ],
            ),
          DataRow(
            cells: <DataCell>[
              DataCell(
                Text(
                  getTranslation(context, 'speciesScientificName'),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              DataCell(Text(model.scientificName!)),
            ],
          ),
          if (model.type != null)
            DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(
                    getTranslation(context, 'speciesType'),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                DataCell(Text(model.type!)),
              ],
            ),
          if (model.conservationStatus != null)
            DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(
                    getTranslation(context, 'speciesConStat'),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                DataCell(Text(model.conservationStatus!)),
              ],
            ),
        ],
      );
}
