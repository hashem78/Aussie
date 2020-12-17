import 'package:aussie/state/multi_image_picking/cubit/multi_image_picking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class EventImageGalleryStatus extends StatelessWidget {
  const EventImageGalleryStatus({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MultiImagePickingCubit, MultiImagePickingState>(
      builder: (context, state) {
        if (state is MultiImageMultiPickingLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MultiImagePickingError) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.close,
                color: Colors.red,
              ),
              Text("No images to be added"),
            ],
          );
        } else if (state is MultiImagePickingDone) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: Colors.green,
              ),
              Text("Added ${state.assets.length} image(s)"),
            ],
          );
        }
        return Container();
      },
    );
  }
}
