import 'package:aussie/interfaces/paginated_data.dart';
import 'package:aussie/models/info/natural_parks/natural_parks_model.dart';
import 'package:aussie/presentation/screens/info/natural_parks/details.dart';
import 'package:aussie/presentation/screens/info/searchable_paginated.dart';
import 'package:aussie/presentation/screens/screen_data.dart';
import 'package:aussie/presentation/widgets/paginated/natural_parks_tile.dart';

import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

class NaturalParksScreen extends StatelessWidget {
  const NaturalParksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchablePaginatedScreen<NaturalParkModel>.list(
      title: getTranslation(context, AussieScreenData.naturalParksTitle),
      filterFor: 'park_name',
      thumbnailCubitRoute: AussieScreenData.naturalParksThumbnailRoute,
      itemBuilder: (_, IPaginatedData item, int index) {
        final NaturalParkModel _casted = item as NaturalParkModel;
        final UniqueKey _key = UniqueKey();
        return NaturalParksTile(
          heroTag: _key.toString(),
          model: _casted,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => NaturalParksDetailsScreen(
                heroTag: _key.toString(),
                model: _casted,
              ),
            ),
          ),
        );
      },
    );
  }
}
