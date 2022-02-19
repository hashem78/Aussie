import 'package:aussie/aussie_imports.dart';

class EventCreationScreen extends StatelessWidget {
  final Function? closeAction;

  const EventCreationScreen({Key? key, this.closeAction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // void _sn(String text) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(text),
    //     ),
    //   );
    // }

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        closeAction!();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(getTranslation(context, 'eventCreationTitle')),
          toolbarHeight: 100,
          flexibleSpace: const AspectRatio(
            aspectRatio: 16 / 9,
            child: EventBannerPicker(),
          ),
          actions: <Widget>[
            BlocBuilder<SingleImagePickingCubit, SingleImagePickingState>(
              builder: (BuildContext context, SingleImagePickingState state) {
                Widget? child;
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
                        getTranslation(context, 'eventCreationAddBannerTip'),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      context.read<SingleImagePickingCubit>().pickImage(
                            aspectRatio:
                                const CropAspectRatio(ratioX: 16, ratioY: 9),
                            cropStyle: CropStyle.rectangle,
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
          builder: (BuildContext context, BoxConstraints constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    EventCreationFormFields(),
                    EventLocationPicker(),
                    EventImageGalleryStatus(),
                    EventImageGalleryPickerButton(),
                    EventCreationSubmitButton(enabled: true),
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
