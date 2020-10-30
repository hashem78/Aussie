import 'package:Aussie/constants.dart';
import 'package:Aussie/models/species/species.dart';
import 'package:Aussie/screens/info/species/species.dart';

import 'package:flutter/material.dart';

class FaunaScreen extends StatelessWidget {
  static String navPath = "/main/info/fauna";
  static String svgName = "fauna.svg";
  static String title = "Fauna";
  @override
  Widget build(BuildContext context) {
    return SpeciesScreen(
      title: "Australian Fauna",
      models: [
        SpeciesDetailsModel(
          commonName: "null",
          scientificName: "null",
          type: "null",
          titleImageUrl: kurl,
          description: klorem,
        )
      ],
    );
  }
}
