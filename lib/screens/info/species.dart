import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/constants.dart';
import 'package:Aussie/size_config.dart';
import 'package:Aussie/util/functions.dart';
import 'package:Aussie/widgets/animated/expanded_text_tile.dart';

class SpeciesScreen extends StatelessWidget {
  final List<SpeciesDescriptionModel> models;
  final String title;
  const SpeciesScreen({
    @required this.models,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            expandedHeight: 250,
            stretchTriggerOffset: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: CarouselSlider.builder(
                itemCount: models.length,
                itemBuilder: (BuildContext context, int index) =>
                    models[index].titleImage,
                options: CarouselOptions(
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  height: 250,
                  viewportFraction: 1,
                  pageSnapping: false,
                  autoPlay: true,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => Ink(
                color: getRandomColor(),
                child: ListTile(
                  title: Text("Australian Sea Lion"),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SpeciesDescription(
                        model: SpeciesDescriptionModel(
                          titleImage: models[index].titleImage,
                          conservationStatus: "Endangered",
                          scientificName: "Neophoca cinerea",
                          type: "Mammal, Otariidae",
                          commonName: "Australian Sea Lion",
                          description: klorem,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class SpeciesDescriptionModel {
  final String commonName;
  final String scientificName;
  final String type;
  final String conservationStatus;
  final String description;
  final CachedNetworkImage titleImage;
  const SpeciesDescriptionModel({
    @required this.commonName,
    @required this.scientificName,
    @required this.type,
    this.conservationStatus,
    @required this.titleImage,
    @required this.description,
  }) : assert(
          commonName != null &&
              scientificName != null &&
              type != null &&
              titleImage != null,
          description != null,
        );
}

class SpeciesDescription extends StatelessWidget {
  final SpeciesDescriptionModel model;
  const SpeciesDescription({
    @required this.model,
  }) : assert(
          model != null,
          "A fauna Descriptions' model cannot be null",
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade700,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            expandedHeight: 250,
            stretchTriggerOffset: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(model.commonName),
              stretchModes: [StretchMode.fadeTitle, StretchMode.blurBackground],
              background: model.titleImage,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                buildDataTable(),
                AnimatedExpandingTextTile(
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
