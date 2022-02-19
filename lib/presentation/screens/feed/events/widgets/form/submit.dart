import 'package:aussie/aussie_imports.dart';
import 'package:aussie/providers/providers.dart';
import 'package:aussie/repositories/event_management_repository.dart';
import 'package:aussie/state/location_picking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_picker/uuid.dart';

class EventCreationSubmitButton extends ConsumerWidget {
  final bool enabled;
  const EventCreationSubmitButton({
    Key? key,
    required this.enabled,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // void _sn(String tid) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         getTranslation(context, tid),
    //       ),
    //     ),
    //   );
    // }

    return TextButton(
      onPressed: enabled
          ? () {
              // ignore: close_sinks
              final EventCreationBlocForm _formBloc =
                  context.read<EventCreationBlocForm>();
              final location = ref.read(locationProvider);
              final MultiImagePickingCubit _multiImageCubit =
                  context.read<MultiImagePickingCubit>();
              final SingleImagePickingCubit _singleImageCubit =
                  context.read<SingleImagePickingCubit>();

              // ignore: always_specify_types
              final TextFieldBloc _title = _formBloc.title;
              // ignore: always_specify_types
              final TextFieldBloc _subtitle = _formBloc.subtitle;
              // ignore: close_sinks, always_specify_types
              final DateTime? _start = _formBloc.dateAndTime1.value;
              final TimeOfDay? _startTime = _formBloc.timeonly1.value;
              final DateTime? _end = _formBloc.dateAndTime2.value;
              final TimeOfDay? _endTime = _formBloc.timeonly2.value;

              final DateTime _combined1 = DateTime(
                _start!.year,
                _start.month,
                _start.day,
                _startTime!.hour,
                _startTime.minute,
              );
              final DateTime _combined2 = DateTime(
                _end!.year,
                _end.month,
                _end.day,
                _endTime!.hour,
                _endTime.minute,
              );
              EventManagementRepository.addEvent(
                EventModel.submition(
                  eventId: Uuid().generateV4(),
                  uid: ref
                      .read(scopedUserProvider)
                      .mapOrNull(signedIn: (val) => val.uid)!,
                    
                  startingTimeStamp: _combined1.millisecondsSinceEpoch,
                  endingTimeStamp: _combined2.millisecondsSinceEpoch,
                  lat: location!.latLng!.latitude,
                  lng: location.latLng!.longitude,
                  address: location.formattedAddress!,
                  title: _title.value,
                  subtitle: _subtitle.value,
                  description: _formBloc.description.value,
                  imageData: _multiImageCubit.values,
                  bannerData: _singleImageCubit.value,
                ),
              );
            }
          : null,
      child: Text(
        getTranslation(
          context,
          'eventCreationCreateEventButtonTitle',
        ),
      ),
    );
  }
}
