import 'package:aussie/presentation/screens/feed/events/widgets/event_creation_form_fields.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/banner_picker.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/gallery_picker_button.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/gallery_status.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/location_picker.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/submit.dart';
import 'package:aussie/state/eventmanagement/cubit/eventmanagement_cubit.dart';
import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

class EventCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _sn(String text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<SingleImagePickingCubit>().emitInitial();

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(getTranslation(context, "eventCreationTitle")),
          toolbarHeight: 100,
          flexibleSpace: const AspectRatio(
            aspectRatio: 16 / 9,
            child: EventBannerPicker(),
          ),
          actions: [
            BlocBuilder<SingleImagePickingCubit, SingleImagePickingState>(
              builder: (context, state) {
                Widget child;
                if (state is SingleImagePickingDone) {
                  child = IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      context.read<SingleImagePickingCubit>().emitInitial();
                    },
                  );
                } else if (state is SingleImagePickingInitial) {
                  child = IconButton(
                    tooltip:
                        getTranslation(context, "eventCreationAddBannerTip"),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      context.read<SingleImagePickingCubit>().pickImage(
                            aspectRatio:
                                const CropAspectRatio(ratioX: 16, ratioY: 9),
                          );
                    },
                  );
                }
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: child,
                );
              },
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const EventCreationFormFields(),
                    const EventLocationPicker(),
                    const EventImageGalleryStatus(),
                    const Expanded(child: EventImageGalleryPickerButton()),
                    BlocBuilder<EventManagementCubit, EventManagementState>(
                      builder: (context, state) {
                        if (state is EventManagementPerformingAction) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return Container();
                      },
                    ),
                    Expanded(
                      child: BlocConsumer<EventManagementCubit,
                          EventManagementState>(
                        listener: (context, state) {
                          if (state is EventManagementCreated) {
                            _sn("Event created");
                            Future.delayed(const Duration(seconds: 2))
                                .whenComplete(
                                    () => Navigator.of(context).pop());
                          } else if (state is EventManagementError) {
                            _sn("Failed to create Event");
                          }
                        },
                        builder: (context, state) {
                          if (state is EventManagementPerformingAction) {
                            return const EventCreationSubmitButton(
                                enabled: false);
                          } else {
                            if (state is EventManagementCreated) {
                              return const EventCreationSubmitButton(
                                  enabled: false);
                            } else {
                              return const EventCreationSubmitButton(
                                  enabled: true);
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
