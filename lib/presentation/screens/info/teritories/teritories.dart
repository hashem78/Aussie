import 'package:aussie/interfaces/paginated_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:aussie/models/gmap.dart';
import 'package:aussie/models/info/teritory/teritory.dart';
import 'package:aussie/models/themes/color_data_model.dart';
import 'package:aussie/presentation/screens/gmap_screen.dart';
import 'package:aussie/presentation/screens/info/searchable_paginated.dart';
import 'package:aussie/presentation/screens/screen_data.dart';
import 'package:aussie/presentation/widgets/paginated/tile.dart';
import 'package:aussie/util/functions.dart';

class TeritoriesScreen extends StatelessWidget {
  const TeritoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AussieThemeBuilder(
      dark: AussieScreenColorData.territoreisDark,
      light: AussieScreenColorData.territoriesLight,
      builder: (BuildContext context, AussieColor color) {
        return SearchablePaginatedScreen<TeritoryModel>.list(
          title: getTranslation(context, AussieScreenData.territoriesTitle),
          thumbnailCubitRoute: AussieScreenData.territoriesThumbnailRoute,
          filterFor: 'title',
          itemBuilder: (BuildContext context, IPaginatedData item, int index) {
            final TeritoryModel _casted = item as TeritoryModel;
            return PaginatedScreenTile(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<AussieGMapScreen>(
                  builder: (BuildContext context) {
                    return AussieGMapScreen(
                      model: AussieGMapModel(
                        latitude: _casted.lat,
                        longitude: _casted.lng,
                        title: _casted.city,
                      ),
                    );
                  },
                ),
              ),
              title: Text(
                _casted.city!,
                style: TextStyle(fontSize: 100.sp, fontWeight: FontWeight.w700),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: buildChip(
                            color.swatchColor,
                            getTranslation(context, 'population'),
                            _casted.population!,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: buildChip(
                            color.swatchColor,
                            getTranslation(context, 'longitude'),
                            _casted.lng!,
                          ),
                        ),
                        Expanded(
                          child: buildChip(
                            color.swatchColor,
                            getTranslation(context, 'latitude'),
                            _casted.lat!,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildChip(Color chipColor, String title, String value) {
    return SizedBox(
      height: .08.sh,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        shape: const RoundedRectangleBorder(),
        color: chipColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 65.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Text(value),
            )
          ],
        ),
      ),
    );
  }
}

class AussieGMapScreen extends StatelessWidget {
  final AussieGMapModel? model;
  const AussieGMapScreen({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          model!.title!,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40.sp),
        ),
        centerTitle: true,
      ),
      body: AussieGMap(
        size: const Size(double.infinity, double.infinity),
        model: model!,
      ),
    );
  }
}
