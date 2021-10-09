import 'package:aussie/aussie_imports.dart';

class EventCreationScreen extends StatelessWidget {
  final Function? closeAction;

  const EventCreationScreen({Key? key, this.closeAction}) : super(key: key);
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
                  children: <Widget>[
                    const EventCreationFormFields(),
                    const EventLocationPicker(),
                    const EventImageGalleryStatus(),
                    const EventImageGalleryPickerButton(),
                    BlocBuilder<EMCubit, EMCState>(
                      builder: (BuildContext context, EMCState state) {
                        if (state is EMCPerformingAction) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container();
                      },
                    ),
                    BlocConsumer<EMCubit, EMCState>(
                      listener: (BuildContext context, EMCState state) {
                        if (state is EMCCreated) {
                          _sn('Event created');
                          Future<void>.delayed(
                            const Duration(
                              seconds: 2,
                            ),
                          ).whenComplete(
                            () {
                              Navigator.of(context).pop();
                            },
                          );
                        } else if (state is EMCError) {
                          _sn('Failed to create Event');
                        }
                      },
                      builder: (BuildContext context, EMCState state) {
                        if (state is EMCPerformingAction) {
                          return const EventCreationSubmitButton(
                            enabled: false,
                          );
                        } else {
                          if (state is EMCCreated) {
                            return const EventCreationSubmitButton(
                              enabled: false,
                            );
                          } else {
                            return const EventCreationSubmitButton(
                              enabled: true,
                            );
                          }
                        }
                      },
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
