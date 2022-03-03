import 'package:evento/models/location_picking_state/location_picking_state.dart';
import 'package:evento/presentation/screens/events/widgets/form/widgets/event_creation_section_title.dart';
import 'package:evento/presentation/screens/events/widgets/location_picker.dart';
import 'package:evento/state/location_picking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:place_picker/entities/entities.dart';

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
              decoration: InputDecoration(
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
