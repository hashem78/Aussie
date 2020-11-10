import 'package:Aussie/models/paginated/natural_parks/natural_parks.dart';
import 'package:Aussie/presentation/screens/searchable_paginated.dart';
import 'package:Aussie/presentation/widgets/paginated/tile.dart';

import 'package:Aussie/state/paginated/natural_parks/natural_parks_cubit.dart';
import 'package:Aussie/util/functions.dart';
import 'package:expand_widget/expand_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NaturalParksScreen extends StatelessWidget {
  static String navPath = "/main/info/naturalParks";
  static String svgName = "parks.svg";
  static String title = "Natural Parks";
  final NaturalParksCubit cubit = NaturalParksCubit();
  @override
  Widget build(BuildContext context) {
    return SearchablePaginatedScreen(
      cubit: cubit,
      itemBuilder: (context, item, index) {
        var _casted = item as NaturalParkModel;
        return PaginatedScreenTile(
            title: Text(
              _casted.parkName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            subtitle: ExpandText(
              "Long: ${_casted.longitude}, Lat: ${_casted.latitude}, Summary: ${_casted.summary}",
              maxLines: 4,
            ),
            titleImage: buildImage(_casted.imageUrl));
      },
    );
  }
}
