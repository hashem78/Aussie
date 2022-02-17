import 'package:aussie/interfaces/paginated_data.dart';
import 'package:aussie/models/info/species/species_model.dart';
import 'package:aussie/presentation/screens/info/searchable_paginated.dart';
import 'package:aussie/presentation/screens/info/species/details.dart';
import 'package:aussie/presentation/screens/screen_data.dart';

import 'package:aussie/util/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FloraScreen extends StatelessWidget {
  const FloraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchablePaginatedScreen<SpeciesDetailsModel>(
      title: getTranslation(context, AussieScreenData.floraTitle),
      thumbnailCubitRoute: AussieScreenData.floraThumbnailRoute,
      filterFor: 'commonName',
      itemBuilder: (BuildContext context, IPaginatedData item, int index) {
        final SpeciesDetailsModel _casted = item as SpeciesDetailsModel;
        Widget child;
        if (_casted.imageUrls!.isNotEmpty) {
          child = Ink.image(
            image: CachedNetworkImageProvider(_casted.imageUrls![0]),
            fit: BoxFit.cover,
          );
        } else {
          child = Center(child: Text(_casted.commonName!));
        }
        return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<SpeciesDetails>(
                  builder: (BuildContext context) {
                    return SpeciesDetails(model: item);
                  },
                ),
              );
            },
            child: child);
      },
    );
  }
}
