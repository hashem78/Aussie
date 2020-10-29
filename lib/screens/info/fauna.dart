import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/statistics/species.dart';
import 'package:Aussie/util/functions.dart';
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
        SpeciesDescriptionModel(
          commonName: "null",
          scientificName: "null",
          type: "null",
          titleImage: buildImage(kurl),
          description: klorem,
        )
      ],
    );
  }
}
