import 'package:aussie/state/multi_image_picking/cubit/multi_image_picking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventImageGalleryPickerButton extends StatelessWidget {
  const EventImageGalleryPickerButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        context.read<MultiImagePickingCubit>().pickImages();
      },
      child: Text("Pick Images"),
    );
  }
}
