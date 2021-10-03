import 'package:aussie/aussie_imports.dart';
import 'package:place_picker/entities/localization_item.dart';

class EventLocationPicker extends StatelessWidget {
  const EventLocationPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationPickingCubit, LocationPickingState>(
      builder: (context, state) {
        String? hintText;
        Locale locale = const Locale("en");
        if (state is LocationNotPicked) {
          hintText = getTranslation(context, state.message);
        } else if (state is LocationPicked) {
          hintText = state.result.formattedAddress;
          locale = AussieLocalizations.of(context)!.locale;
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
                      builder: (context) {
                        return PlacePicker(
                          "AIzaSyBs7N7qU5nNLY-fNcnesbnJFJZ3bo55o6k",
                          displayLocation: const LatLng(-33.8688, 151.2093),
                          localizationItem: LocalizationItem(
                            languageCode: locale.languageCode,
                            nearBy: getTranslation(
                              context,
                              "locationNearby",
                            )!,
                            findingPlace: getTranslation(
                              context,
                              "locationFindingPlace",
                            )!,
                            unnamedLocation: getTranslation(
                              context,
                              "locationUnamedLocation",
                            )!,
                            noResultsFound: getTranslation(
                              context,
                              "locationNoResultsFound",
                            )!,
                            tapToSelectLocation: getTranslation(
                              context,
                              "locationTapToSelect",
                            )!,
                          ),
                        );
                      },
                    ),
                  );
                  final _locCubit = context.read<LocationPickingCubit>();
                  _locCubit.pickLoc(_k);
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
      },
    );
  }
}
