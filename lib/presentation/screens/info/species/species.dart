import 'package:aussie/models/paginated/species/species.dart';
import 'package:aussie/presentation/screens/info/species/details.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import 'package:aussie/constants.dart';

import 'package:aussie/util/functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeciesScreen extends StatelessWidget {
  final List<SpeciesDetailsModel> models;
  final String title;

  const SpeciesScreen({
    @required this.models,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            stretch: true,
            expandedHeight: 250.h,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(title),
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: CarouselSlider.builder(
                itemCount: models.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildImage(models[index].titleImageUrl),
                options: CarouselOptions(
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  height: 250.h,
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
                      builder: (BuildContext context) => SpeciesDetails(
                        model: SpeciesDetailsModel(
                          titleImageUrl: models[index].titleImageUrl,
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
