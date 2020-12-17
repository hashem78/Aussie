import 'package:aussie/models/usermanagement/events/creation/eventcreation_model.dart';
import 'package:aussie/state/event_creation/form_bloc.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';
import 'package:aussie/state/location_picking/cubit/locationpicking_cubit.dart';
import 'package:aussie/state/multi_image_picking/cubit/multi_image_picking_cubit.dart';
import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:provider/provider.dart';

class EventCreationSubmitButton extends StatelessWidget {
  const EventCreationSubmitButton({
    Key key,
    @required this.scaffkey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffkey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventManagementCubit, EventManagementState>(
      listenWhen: (previous, current) {
        if (previous is EventManagementPerformingAction)
          return false;
        else if (current is EventManagementPerformingAction) return false;
        return true;
      },
      listener: (context, state) {
        if (state is EventManagementCreated) {
          _sn("Event created");
          Future.delayed(Duration(seconds: 2))
              .whenComplete(() => Navigator.of(context).pop());
        } else {
          _sn("Failed to create Event");
        }
      },
      builder: (context, state) {
        bool enabled = true;
        if (state is EventManagementPerformingAction) enabled = false;
        return OutlinedButton(
          onPressed: enabled
              ? () {
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

                    final _multiImageCubit =
                        context.read<MultiImagePickingCubit>();
                    final _singleImageCubit =
                        context.read<SingleImagePickingCubit>();
                    final _evmCubit = context.read<EventManagementCubit>();

                    if (_evmCubit.validate(_locCubit.value)) {
                      _sn("Choose a valid location");
                      return;
                    } else if (_evmCubit.validate(_singleImageCubit.value)) {
                      _sn("Please choose a banner for you event");
                      return;
                    } else if (_evmCubit.validate(_multiImageCubit.values)) {
                      _sn("Please add atleast an image to your events' gallery");
                      return;
                    } else
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
              : null,
          child: Text("Create Event"),
        );
      },
    );
  }

  void _sn(String text) {
    scaffkey.currentState.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
