import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EventBannerPicker extends StatelessWidget {
  const EventBannerPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingleImagePickingCubit, SingleImagePickingState>(
      listener: (context, state) {
        if (state is SingleImagePickingError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
                const SnackBar(
                  content: Text('No banner selected'),
                ),
              )
              .closed
              .whenComplete(
            () {
              context.read<SingleImagePickingCubit>().emitInitial();
            },
          );
        }
      },
      builder: (context, state) {
        Widget? child;
        if (state is SingleImagePickingDone) {
          child = Ink.image(
            image: MemoryImage(
              state.data!.byteData!.buffer.asUint8List(),
            ),
            fit: BoxFit.cover,
          );
        } else if (state is SingleImagePickingInitial) {
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
