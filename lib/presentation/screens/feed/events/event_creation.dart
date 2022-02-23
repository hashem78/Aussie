import 'package:aussie/models/date_range_picking_state/date_range_picking_state.dart';
import 'package:aussie/models/event/event_model.dart';
import 'package:aussie/models/location_picking_state/location_picking_state.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/location_picker.dart';
import 'package:aussie/repositories/event_management_repository.dart';
import 'package:aussie/state/date_range_picking.dart';
import 'package:aussie/state/image_picking.dart';
import 'package:aussie/state/location_picking.dart';
import 'package:aussie/state/user_management.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:uuid/uuid.dart';

class EventCreationScreen extends HookWidget {
  const EventCreationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Row(
                children: [
                  IconButton(
                    iconSize: 125.sp,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  Text(
                    'New Event',
                    style: TextStyle(fontSize: 100.sp),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: EventCreationForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

var _formKey = GlobalKey<FormState>();

class EventCreationForm extends HookConsumerWidget {
  const EventCreationForm({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final subtitileController = useTextEditingController();
    final descriptionController = useTextEditingController();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 30,
          children: [
            const EventCreationBannerPicker(),
            const EventCreationGalleryPicker(),
            EventCreationTitles(
              titleController: titleController,
              subtitileController: subtitileController,
            ),
            EventCreationDescription(
              descriptionController: descriptionController,
            ),
            const EventCreationDateRangeSection(),
            const EventCreationLocationPicker(),
            EventCreationSubmitionButton(
              titleController: titleController,
              subtitileController: subtitileController,
              descriptionController: descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}

class EventCreationSubmitionButton extends ConsumerWidget {
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
    return SizedBox(
      width: 1.sw,
      child: OutlinedButton(
        onPressed: () async {
          final isFormContentAndDateValid = _formKey.currentState!.validate();
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
            await EventManagementRepository.addEvent(
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
            Navigator.of(context).pop();
          }
        },
        child: const Text('Create new event'),
      ),
    );
  }
}

class EventCreationLocationPicker extends HookConsumerWidget {
  const EventCreationLocationPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationController = ref.watch(locationProvider);
    final controller = useTextEditingController();
    ref.listen<LocationPickingState>(
      locationProvider,
      ((previous, next) {
        if (next != const LocationPickingState.notPicked() &&
            next != const LocationPickingState.error()) {
          controller.text = next.whenOrNull(
            picked: (val) => val.formattedAddress!,
          )!;
        }
      }),
    );

    return GestureDetector(
      onTap: () async {
        final location = await Navigator.push(
          context,
          MaterialPageRoute<LocationResult?>(
            builder: (_) => const EventLocationPicker(),
          ),
        );
        if (location != null) {
          print(location);

          ref.read(locationProvider.notifier).pick(location);
        }
      },
      child: Column(
        children: [
          const EventCreationSectionTitle(
            text: 'Location',
            iconData: Icons.pin_drop,
          ),
          SizedBox(
            height: .02.sh,
          ),
          AbsorbPointer(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: controller,
              readOnly: true,
              maxLines: 2,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                hintText: locationController.whenOrNull(
                  notPicked: () => 'Select a location',
                  error: () {
                    return 'Select a location';
                  },
                ),
              ),
              validator: (val) => RequiredValidator(
                errorText: 'This field is required',
              ).call(val),
            ),
          ),
        ],
      ),
    );
  }
}

class EventCreationDescription extends StatelessWidget {
  const EventCreationDescription({
    Key? key,
    required this.descriptionController,
  }) : super(key: key);

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventCreationSectionTitle(
          text: 'Description',
          iconData: Icons.description,
        ),
        SizedBox(
          height: .02.sh,
        ),
        SizedBox(
          height: .3.sh,
          child: TextFormField(
            controller: descriptionController,
            autovalidateMode: AutovalidateMode.always,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            expands: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              filled: true,
            ),
            validator: (val) => MultiValidator(
              [
                RequiredValidator(errorText: 'This field is required'),
                MinLengthValidator(
                  100,
                  errorText:
                      'Your Description has to be at least 100 characters long',
                ),
                MaxLengthValidator(
                  500,
                  errorText:
                      'Your Description has to be less than 500 characters long',
                ),
              ],
            ).call(val),
          ),
        ),
      ],
    );
  }
}

class EventCreationTitles extends StatelessWidget {
  const EventCreationTitles({
    Key? key,
    required this.titleController,
    required this.subtitileController,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController subtitileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EventCreationSectionTitle(
          text: 'Titles',
          iconData: Icons.title,
        ),
        SizedBox(
          height: .02.sh,
        ),
        TextFormField(
          controller: titleController,
          autovalidateMode: AutovalidateMode.always,
          decoration: const InputDecoration(
            labelText: 'Title',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.text_fields),
          ),
          validator: (val) => MultiValidator(
            [
              RequiredValidator(errorText: 'This field is required'),
              MinLengthValidator(
                10,
                errorText: 'Title has to be a tleast 10 characters long',
              ),
            ],
          ).call(val),
        ),
        SizedBox(height: 0.02.sh),
        TextFormField(
          controller: subtitileController,
          autovalidateMode: AutovalidateMode.always,
          decoration: const InputDecoration(
            labelText: 'Sub title',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(Icons.text_fields),
          ),
          validator: (val) => MultiValidator(
            [
              RequiredValidator(errorText: 'This field is required'),
              MinLengthValidator(
                10,
                errorText: 'Sub title has to be at least 10 characters long',
              ),
            ],
          ).call(val),
        ),
      ],
    );
  }
}

class EventCreationGalleryPicker extends ConsumerWidget {
  const EventCreationGalleryPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final galleryPicker = ref.watch(
      imagePickerProvier(PickerUse.gallery),
    );
    return GestureDetector(
      onTap: () {
        ref.read(imagePickerProvier(PickerUse.gallery).notifier).pick(
          PickingMode.multi,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
          ],
        );
      },
      child: Column(
        children: [
          const EventCreationSectionTitle(
            text: 'Gallery',
            iconData: Icons.photo_library,
          ),
          SizedBox(
            height: .02.sh,
          ),
          Container(
            height: 0.5.sh,
            color: Colors.black.withOpacity(0.05),
            child: galleryPicker.when(
              picked: (images) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.memory(
                            images[index].byteData,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Material(
                              type: MaterialType.transparency,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  ref
                                      .read(
                                        imagePickerProvier(PickerUse.gallery)
                                            .notifier,
                                      )
                                      .remove(index);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: images.length,
                );
              },
              notPicked: () {
                return const Center(
                  child: Text('Tap to add images to event'),
                );
              },
              error: () {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'You have to add at least one image to your gallery.',
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    const Text('Tap to add images to event'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EventCreationBannerPicker extends ConsumerWidget {
  const EventCreationBannerPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePicker = ref.watch(imagePickerProvier(PickerUse.banner));

    return Column(
      children: [
        const EventCreationSectionTitle(
          text: 'Banner',
          iconData: Icons.image,
        ),
        SizedBox(
          height: .02.sh,
        ),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ColoredBox(
            color: Colors.black.withOpacity(0.05),
            child: imagePicker.when(
              picked: (images) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.memory(images.first.byteData),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Material(
                        type: MaterialType.transparency,
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            ref
                                .read(
                                  imagePickerProvier(PickerUse.banner).notifier,
                                )
                                .remove(0);
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
              notPicked: () {
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(imagePickerProvier(PickerUse.banner).notifier)
                        .pick(
                      PickingMode.single,
                      shouldCrop: true,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.ratio16x9,
                      ],
                    );
                  },
                  child: const Center(
                    child: Text('Tap to select a banner'),
                  ),
                );
              },
              error: () {
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(imagePickerProvier(PickerUse.banner).notifier)
                        .pick(
                      PickingMode.single,
                      shouldCrop: true,
                      aspectRatioPresets: [
                        CropAspectRatioPreset.ratio16x9,
                      ],
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'You have to add a banner to your event.',
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(height: 0.01.sh),
                      const Text('Tap to select a banner'),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class EventCreationDateRangeSection extends HookConsumerWidget {
  const EventCreationDateRangeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txtCntrl1 = useTextEditingController();
    final txtCntrl2 = useTextEditingController();

    ref.listen<DateRangePickingState>(
      dateRangeProvider,
      (p, n) {
        if (n != const DateRangePickingState.notPicked() &&
            n != const DateRangePickingState.error()) {
          final formatter = DateFormat();
          txtCntrl1.text = n.whenOrNull(
            picked: (val) => formatter.format(val.start),
          )!;
          txtCntrl2.text = n.whenOrNull(
            picked: (val) => formatter.format(val.end),
          )!;
        }
      },
    );
    return GestureDetector(
      onTap: () async {
        final range = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 30),
          ),
        );
        final startingTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              helpText: 'Select Starting Time',
            ) ??
            const TimeOfDay(hour: 0, minute: 0);

        final endingTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              helpText: 'Select Ending Time',
            ) ??
            const TimeOfDay(hour: 0, minute: 0);
        if (range != null) {
          final joinedStartingDate = joinDateWithTime(
            range.start,
            startingTime,
          );
          final joinedEndingDate = joinDateWithTime(
            range.end,
            endingTime,
          );
          ref.read(dateRangeProvider.notifier).pick(
                DateTimeRange(
                  start: joinedStartingDate,
                  end: joinedEndingDate,
                ),
              );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EventCreationSectionTitle(
            text: 'Date',
            iconData: Icons.calendar_today,
          ),
          SizedBox(
            height: .02.sh,
          ),
          AbsorbPointer(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: txtCntrl1,
              readOnly: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                prefixIcon: Icon(Icons.date_range),
                labelText: 'Starting on',
              ),
              validator: (val) => RequiredValidator(
                errorText: 'This field is required',
              ).call(val),
            ),
          ),
          SizedBox(
            height: 0.03.sh,
          ),
          AbsorbPointer(
            child: TextFormField(
              controller: txtCntrl2,
              autovalidateMode: AutovalidateMode.always,
              readOnly: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                prefixIcon: Icon(Icons.date_range),
                labelText: 'Ending on',
              ),
              validator: (val) => RequiredValidator(
                errorText: 'This field is required',
              ).call(val),
            ),
          ),
        ],
      ),
    );
  }
}

class EventCreationSectionTitle extends StatelessWidget {
  const EventCreationSectionTitle({
    Key? key,
    required this.text,
    required this.iconData,
  }) : super(key: key);
  final String text;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: Colors.black.withOpacity(.5),
        ),
        SizedBox(
          width: 0.03.sw,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 75.sp,
              color: Colors.black.withOpacity(.5),
            ),
          ),
        ),
      ],
    );
  }
}
