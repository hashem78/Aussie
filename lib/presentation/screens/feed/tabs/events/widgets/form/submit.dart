import 'package:aussie/models/usermanagement/events/creation/eventcreation_model.dart';
import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';
import 'package:aussie/state/location_picking/cubit/locationpicking_cubit.dart';
import 'package:aussie/state/multi_image_picking/cubit/multi_image_picking_cubit.dart';
import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCreationSubmitButton extends StatelessWidget {
  const EventCreationSubmitButton({
    Key key,
    @required this.scaffkey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffkey;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // ignore: close_sinks
        final _formBloc = context.read<EventCreationBlocForm>();
        _formBloc.submit();
        if (!_formBloc.state.canSubmit) {
          final _start = _formBloc.dateAndTime1.value;
          final _startTime = _formBloc.timeonly1.value;
          final _end = _formBloc.dateAndTime2.value;
          final _endTime = _formBloc.timeonly2.value;
          final _combined1 = DateTime(
            _start.year,
            _start.month,
            _start.day,
            _startTime.hour,
            _startTime.minute,
          );
          final _combined2 = DateTime(
            _end.year,
            _end.month,
            _end.day,
            _endTime.hour,
            _endTime.minute,
          );
          final _locCubit = context.read<LocationPickingCubit>();
          final _multiImageCubit = context.read<MultiImagePickingCubit>();
          final _singleImageCubit = context.read<SingleImagePickingCubit>();
          final _evmCubit = context.read<EventManagementCubit>();
          _evmCubit.validateLocation(
            _locCubit.value,
            "Choose a valid location",
          );
          _evmCubit.validateSingleImage(
            _singleImageCubit.value,
            "Please choose a banner for you event",
          );
          _evmCubit.validateMultiImage(
            _multiImageCubit.values,
            "Please add atleast an image to your events' gallery",
          );
          final _evmstate = _evmCubit.state;
          if (_evmstate is EventManagementError) {
            print("here");
            scaffkey.currentState.showSnackBar(
              SnackBar(
                content: Text(_evmstate.error),
              ),
            );
          } else {
            _evmCubit.addEvent(
              EventCreationModel(
                startingTimeStamp: _combined1.millisecondsSinceEpoch,
                endingTimeStamp: _combined2.millisecondsSinceEpoch,
                lat: _locCubit.value.latLng.latitude,
                lng: _locCubit.value.latLng.longitude,
                address: _locCubit.value.formattedAddress,
                title: _formBloc.title.value,
                subtitle: _formBloc.subtitle.value,
                description: _formBloc.description.value,
                imageData: _multiImageCubit.values,
                bannerData: _singleImageCubit.value,
              ),
            );
          }
        }
      },
      child: Text("Create Event"),
    );
  }
}
