import 'package:aussie/presentation/screens/info/natural_parks/details.dart';
import 'package:aussie/presentation/widgets/paginated/natural_parks_tile.dart';
import 'package:aussie/state/paginated/cubit/aussiepaginated_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:aussie/models/paginated/natural_parks/natural_parks.dart';
import 'package:aussie/presentation/screens/searchable_paginated.dart';

class NaturalParksScreen extends StatelessWidget {
  static String navPath = "/main/info/naturalParks";
  static String svgName = "parks.svg";
  static String title = "Natural Parks";
  final AussiePaginatedCubit<NaturalParkModel> cubit =
      AussiePaginatedCubit("naturalParks");
  @override
  Widget build(BuildContext context) {
    return SearchablePaginatedScreen(
      cubit: cubit,
      title: title,
      filterFor: "park_name",
      thumbnailCubitRoute: "park_images",
      itemBuilder: (context, item, index) {
        var _casted = item as NaturalParkModel;
        var _key = UniqueKey();
        return NaturalParksTile(
          heroTag: _key.toString(),
          model: _casted,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return NaturalParksDetailsScreen(
                  heroTag: _key.toString(),
                  model: _casted,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
