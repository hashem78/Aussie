import 'package:aussie/state/paginated/cubit/aussiepaginated_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/models/gmap.dart';
import 'package:aussie/models/paginated/teritories/teritory.dart';
import 'package:aussie/presentation/screens/gmap_screen.dart';
import 'package:aussie/presentation/screens/searchable_paginated.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';

class TeritoriesScreen extends StatelessWidget {
  static String navPath = "/main/info/teritories";
  static String svgName = "australia.svg";
  static String title = "Teritories";
  final AussiePaginatedCubit<TeritoryModel> cubit =
      AussiePaginatedCubit("teritories");
  @override
  Widget build(BuildContext context) {
    return SearchablePaginatedScreen(
      title: title,
      thumbnailCubitRoute: "teritory_images",
      cubit: cubit,
      filterFor: "title",
      itemBuilder: (context, item, index) {
        var _casted = item as TeritoryModel;
        return PaginatedScreenTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AussieGMapScreen(
                model: AussieGMapModel(
                  latitude: _casted.latitude,
                  longitude: _casted.longitude,
                  title: _casted.title,
                ),
              ),
            ),
          ),
          title: Text(
            _casted.title,
            style: TextStyle(fontSize: 100.sp, fontWeight: FontWeight.w800),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: buildChip("Population", _casted.population),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(child: buildChip("Longitude", _casted.longitude)),
                    Expanded(child: buildChip("Latitude", _casted.latitude)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildChip(String title, String value) {
    return SizedBox(
      height: .08.sh,
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(horizontal: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 65.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                value,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AussieGMapScreen extends StatelessWidget {
  final AussieGMapModel model;
  const AussieGMapScreen({
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          model.title,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 100.sp),
        ),
        centerTitle: true,
      ),
      body: AussieGMap(
        size: Size(double.infinity, double.infinity),
        model: model,
      ),
    );
  }
}
