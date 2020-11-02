import 'package:Aussie/models/teritories/teritory.dart';
import 'package:Aussie/screens/searchable_paginated.dart';
import 'package:Aussie/widgets/paginated/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:Aussie/state/teritories/teritories_cubit.dart';

class TeritoriesScreen extends StatelessWidget {
  static String navPath = "/main/info/teritories";
  static String svgName = "australia.svg";
  static String title = "Teritories";
  final TeritoriesCubit cubit = TeritoriesCubit();
  @override
  Widget build(BuildContext context) {
    return SearchablePaginatedScreen(
      cubit: cubit,
      itemBuilder: (context, item, index) {
        var _casted = item as TeritoryModel;
        return PaginatedScreenTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TeritoryMapScreen(
                model: _casted,
              ),
            ),
          ),
          title: Text(
            _casted.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
              "Long: ${_casted.longitude}, Lat: ${_casted.latitude}, Admin: ${_casted.admin}"),
        );
      },
    );
  }
}
