import 'package:Aussie/models/paginated/species/species.dart';
import 'package:Aussie/screens/info/species/details.dart';
import 'package:Aussie/screens/searchable_paginated.dart';
import 'package:Aussie/state/paginated/species/flora_cubit.dart';
import 'package:Aussie/widgets/paginated/tile.dart';

import 'package:flutter/material.dart';

class FloraScreen extends StatelessWidget {
  static String navPath = "/main/info/flora";
  static String svgName = "flora.svg";
  static String title = "Flora";
  final FloraCubit cubit = FloraCubit();
  @override
  Widget build(BuildContext context) {
    return SearchablePaginatedScreen(
      cubit: cubit,
      itemBuilder: (context, item, index) {
        var _casted = item as SpeciesDetailsModel;
        return PaginatedScreenTile(
          title: Text(
            _casted.commonName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpeciesDetails(
                model: item,
              ),
            ),
          ),
        );
      },
    );
  }
}