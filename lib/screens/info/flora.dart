import 'package:Aussie/constants.dart';
import 'package:Aussie/models/species/species.dart';
import 'package:Aussie/screens/info/species/species.dart';

import 'package:flutter/material.dart';

class FloraScreen extends StatelessWidget {
  static String navPath = "/main/info/flora";
  static String svgName = "flora.svg";
  static String title = "Flora";

  @override
  Widget build(BuildContext context) {
    return SpeciesScreen(
      title: "Australian Flora",
      models: [
        SpeciesDetailsModel(
          commonName: "null",
          scientificName: "null",
          type: "null",
          titleImageUrl: kurl,
          description: klorem,
        ),
      ],
    );
  }
}
