import 'package:aussie/state/single_image_picking/cubit/single_image_picking_cubit.dart';
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
            if (state is SingleImagePickingDone) {
              return Ink.image(
                image: MemoryImage(
                  state.data.buffer.asUint8List(),
                ),
                fit: BoxFit.cover,
              );
            } else if (state is SingleImagePickingInitial) {
              return Container();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        IconButton(
          tooltip: "Add a banner",
          icon: Icon(Icons.add),
          onPressed: () {
            final _singleImageCubit = context.read<SingleImagePickingCubit>();

            _singleImageCubit.pickImage();
          },
        ),
      ],
    );
  }
}
