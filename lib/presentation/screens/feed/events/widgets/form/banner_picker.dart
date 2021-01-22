import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EventBannerPicker extends StatelessWidget {
  const EventBannerPicker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        BlocBuilder<SingleImagePickingCubit, SingleImagePickingState>(
            builder: (context, state) {
          Widget child;
          if (state is SingleImagePickingDone) {
            child = Ink.image(
              image: MemoryImage(
                state.data.byteData.buffer.asUint8List(),
              ),
              fit: BoxFit.cover,
            );
          } else if (state is SingleImagePickingInitial) {
            child = const SizedBox();
          } else {
            child = const Center(
              child: CircularProgressIndicator(),
            );
          }
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: child,
          );
        }),
        IconButton(
          tooltip: getTranslation(context, "eventCreationAddBannerTip"),
          icon: const Icon(Icons.add),
          onPressed: () {
            context.read<SingleImagePickingCubit>().pickImage();
          },
        ),
      ],
    );
  }
}
