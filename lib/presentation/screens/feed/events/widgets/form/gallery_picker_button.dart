import 'package:aussie/aussie_imports.dart';

class EventImageGalleryPickerButton extends StatelessWidget {
  const EventImageGalleryPickerButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<MultiImagePickingCubit>().pickImages();
      },
      child: Text(getTranslation(context, 'eventCreationPickerButtonText')),
    );
  }
}
