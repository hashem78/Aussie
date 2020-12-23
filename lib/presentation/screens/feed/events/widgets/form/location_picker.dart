import 'package:aussie/state/location_picking/cubit/locationpicking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:place_picker/place_picker.dart';

class EventLocationPicker extends StatelessWidget {
  const EventLocationPicker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationPickingCubit, LocationPickingState>(
      builder: (context, state) {
        return TextField(
          readOnly: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.map),
            suffixIcon: IconButton(
              onPressed: () async {
                final _k = await Navigator.of(context).push(
                  MaterialPageRoute<LocationResult>(
                    builder: (context) => PlacePicker(
                      "AIzaSyBs7N7qU5nNLY-fNcnesbnJFJZ3bo55o6k",
                      displayLocation: const LatLng(-33.8688, 151.2093),
                    ),
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
            hintText: state.message,
          ),
        );
      },
    );
  }
}
