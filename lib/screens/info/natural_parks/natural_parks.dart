import 'package:Aussie/models/paginated/natural_parks/natural_parks.dart';
import 'package:Aussie/screens/searchable_paginated.dart';
import 'package:Aussie/state/paginated/natural_parks/natural_parks_cubit.dart';

import 'package:Aussie/widgets/paginated/tile.dart';
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
          // onTap: () => Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => TeritoryMapScreen(
          //       model: _casted,
          //     ),
          //   ),
          // ),
          title: Text(
            _casted.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
              "Long: ${_casted.longitude}, Lat: ${_casted.latitude}, Summary: ${_casted.summary}"),
        );
      },
    );
  }
}
