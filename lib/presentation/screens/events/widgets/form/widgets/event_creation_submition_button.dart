import 'package:evento/models/event/event_model.dart';
import 'package:evento/models/submittion_button_state/submition_button_state.dart';
import 'package:evento/presentation/screens/events/widgets/form/event_creation_form.dart';
import 'package:evento/repositories/event_management_repository.dart';
import 'package:evento/state/date_range_picking.dart';
import 'package:evento/state/image_picking.dart';
import 'package:evento/state/location_picking.dart';
import 'package:evento/state/user_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

class EventCreationSubmitionButton extends HookConsumerWidget {
  const EventCreationSubmitionButton({
    Key? key,
    required this.titleController,
    required this.subtitileController,
    required this.descriptionController,
  }) : super(key: key);
  final TextEditingController titleController;
  final TextEditingController subtitileController;
  final TextEditingController descriptionController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final submittionState = useValueNotifier(
      const SubmitionButtonState.inital(),
    );
    return SizedBox(
      width: 1.sw,
      child: OutlinedButton(
        onPressed: () async {
          final isFormContentAndDateValid =
              eventCreationFormKey.currentState!.validate();
          final isLocationPicked = ref
              .read(
                locationProvider.notifier,
              )
              .validate();

          final isBannerPicked = ref
              .read(
                imagePickerProvier(PickerUse.banner).notifier,
              )
              .validate();
          final isGalleryPicked = ref
              .read(
                imagePickerProvier(PickerUse.gallery).notifier,
              )
              .validate();
          if (![
            isFormContentAndDateValid,
            isLocationPicked,
            isBannerPicked,
            isGalleryPicked
          ].contains(false)) {
            final banner = ref
                .read(
                  imagePickerProvier(PickerUse.banner),
                )
                .mapOrNull(
                  picked: (val) => val.images.first,
                )!;
            final gallery =
                ref.read(imagePickerProvier(PickerUse.gallery)).mapOrNull(
                      picked: (val) => val.images,
                    )!;
            final start = ref
                .read(dateRangeProvider)
                .whenOrNull(picked: (val) => val.start)!
                .millisecondsSinceEpoch;
            final end = ref
                .read(dateRangeProvider)
                .whenOrNull(picked: (val) => val.end)!
                .millisecondsSinceEpoch;
            final loc = ref
                .read(locationProvider)
                .whenOrNull(picked: (val) => val.latLng)!;
            final address = ref
                .read(locationProvider)
                .whenOrNull(picked: (val) => val.formattedAddress)!;
            final uid = ref
                .read(scopedUserProvider)
                .mapOrNull(signedIn: (user) => user.uid)!;
            final eventId = const Uuid().v4();
            try {
              submittionState.value = const SubmitionButtonState.submitting();
              final state = await EventManagementRepository.addEvent(
                EventModel.submition(
                  bannerData: banner,
                  imageData: gallery,
                  title: titleController.text,
                  subtitle: subtitileController.text,
                  startingTimeStamp: start,
                  endingTimeStamp: end,
                  lat: loc.latitude,
                  lng: loc.longitude,
                  description: descriptionController.text,
                  address: address,
                  eventId: eventId,
                  uid: uid,
                ),
              );
              state.when(
                sucess: () async {
                  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text('Event created'),
                    ),
                  );
                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.of(context).pop();
                },
                error: () {
                  ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(
                        'An unknown error occured when creating a new event',
                      ),
                    ),
                  );
                },
              );
            } on Exception {
              submittionState.value = const SubmitionButtonState.error();
            }
          } else {
            submittionState.value = const SubmitionButtonState.error();
          }
        },
        child: ValueListenableBuilder<SubmitionButtonState>(
          valueListenable: submittionState,
          builder: (context, value, _) {
            return value.when(
              inital: () {
                return const Text('Create Event');
              },
              submitting: () {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('Submitting Event'),
                  ],
                );
              },
              error: () {
                return const Text(
                  'Create Event',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
