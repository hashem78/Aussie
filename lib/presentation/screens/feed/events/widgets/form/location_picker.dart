import 'package:aussie/localizations.dart';
import 'package:aussie/state/location_picking.dart';
import 'package:aussie/util/functions.dart';
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
    final location = ref.watch(locationProvider);
    String? hintText;
    Locale locale = const Locale('en');
    if (location != null) {
      hintText = location.formattedAddress;
      locale = AussieLocalizations.of(context).locale;
    } else {
      hintText = getTranslation(context, 'locationStateInitial');
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.map),
          suffixIcon: IconButton(
            onPressed: () async {
              final _k = await Navigator.of(context).push(
                MaterialPageRoute<LocationResult>(
                  builder: (BuildContext context) {
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
                  },
                ),
              );
              ref.read(locationProvider.notifier).changeTo(_k);
            },
            icon: const Icon(
              Icons.location_pin,
              color: Colors.red,
            ),
          ),
          border: InputBorder.none,
          filled: true,
          labelText: hintText,
          hintText: getTranslation(context, 'locationStateInitial'),
        ),
      ),
    );
  }
}
