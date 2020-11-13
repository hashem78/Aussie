import 'package:aussie/models/paginated/species/species.dart';
import 'package:aussie/presentation/screens/info/species/details.dart';
import 'package:aussie/presentation/screens/searchable_paginated.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';
import 'package:aussie/state/paginated/species/fauna_cubit.dart';

import 'package:flutter/material.dart';

class FaunaScreen extends StatelessWidget {
  static String navPath = "/main/info/fauna";
  static String svgName = "fauna.svg";
  static String title = "Fauna";
  final FaunaCubit cubit = FaunaCubit();
  @override
  Widget build(BuildContext context) {
    return SearchablePaginatedScreen(
      title: title,
      cubit: cubit,
      thumbnailCubitRoute: "park_images",
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
