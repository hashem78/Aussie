import 'package:aussie/models/gmap.dart';
import 'package:aussie/models/paginated/teritories/teritory.dart';
import 'package:aussie/presentation/screens/gmap_screen.dart';
import 'package:aussie/presentation/screens/searchable_paginated.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';

import 'package:aussie/state/paginated/teritories/teritories_cubit.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeritoriesScreen extends StatelessWidget {
  static String navPath = "/main/info/teritories";
  static String svgName = "australia.svg";
  static String title = "Teritories";
  final TeritoriesCubit cubit = TeritoriesCubit();
  @override
  Widget build(BuildContext context) {
    return SearchablePaginatedScreen(
      title: title,
      thumbnailCubitRoute: "park_images",
      cubit: cubit,
      itemBuilder: (context, item, index) {
        var _casted = item as TeritoryModel;
        return PaginatedScreenTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AussieGMapScreen(
                size: Size(double.infinity, 200),
                model: AussieGMapModel(
                  longitude: _casted.longitude,
                  latitude: _casted.latitude,
                  title: _casted.title,
                ),
              ),
            ),
          ),
          title: Text(
            _casted.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          subtitle: Text(
            "Long: ${_casted.longitude}, Lat: ${_casted.latitude}, Admin: ${_casted.admin}",
          ),
        );
      },
    );
  }
}
