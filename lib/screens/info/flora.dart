import 'package:Aussie/constants.dart';
import 'package:Aussie/screens/statistics/species.dart';
import 'package:Aussie/util/functions.dart';
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
        SpeciesDescriptionModel(
          commonName: "null",
          scientificName: "null",
          type: "null",
          titleImage: buildImage(kurl),
          description: klorem,
        ),
      ],
    );
  }
}
