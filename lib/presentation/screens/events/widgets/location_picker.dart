import 'package:evento/localizations.dart';
import 'package:evento/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_picker/entities/localization_item.dart';
import 'package:place_picker/place_picker.dart';

class EventLocationPicker extends ConsumerWidget {
  const EventLocationPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = AussieLocalizations.of(context).locale;

    return PlacePicker(
      'AIzaSyBs7N7qU5nNLY-fNcnesbnJFJZ3bo55o6k',
      displayLocation: const LatLng(-33.8688, 151.2093),
      localizationItem: LocalizationItem(
        languageCode: locale.languageCode,
        nearBy: getTranslation(
          context,
          'locationNearby',
        ),
        findingPlace: getTranslation(
          context,
          'locationFindingPlace',
        ),
        unnamedLocation: getTranslation(
          context,
          'locationUnamedLocation',
        ),
        noResultsFound: getTranslation(
          context,
          'locationNoResultsFound',
        ),
        tapToSelectLocation: getTranslation(
          context,
          'locationTapToSelect',
        ),
      ),
    );
  }
}
