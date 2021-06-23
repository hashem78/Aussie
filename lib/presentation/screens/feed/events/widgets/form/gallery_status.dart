import 'package:aussie/state/multi_image_picking/cubit/multi_image_picking_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EventImageGalleryStatus extends StatelessWidget {
  const EventImageGalleryStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiImagePickingCubit, MultiImagePickingState>(
      builder: (context, state) {
        Widget child;
        if (state is MultiImageMultiPickingLoading) {
          child = const Center(child: CircularProgressIndicator());
        } else if (state is MultiImagePickingError) {
          child = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.close,
                color: Colors.red,
              ),
              Text(getTranslation(context, "eventCreationMultiImageError")!),
            ],
          );
        } else if (state is MultiImagePickingDone) {
          child = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
              Text(getTranslation(context, "eventCreationMultiImagesAdded")!
                  .replaceFirst(" ", " ${state.assets.length} ")),
            ],
          );
        } else {
          child = const SizedBox();
        }
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      },
    );
  }
}
