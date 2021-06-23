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
          title: Text(getTranslation(context, "eventCreationTitle")!),
          toolbarHeight: 100,
          flexibleSpace: const AspectRatio(
            aspectRatio: 16 / 9,
            child: EventBannerPicker(),
          ),
          actions: [
            BlocBuilder<SingleImagePickingCubit, SingleImagePickingState>(
              builder: (context, state) {
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
                        getTranslation(context, "eventCreationAddBannerTip"),
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
                    const EventImageGalleryPickerButton(),
                    BlocBuilder<EventManagementCubit, EventManagementState>(
                      builder: (context, state) {
                        if (state is EventManagementPerformingAction) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container();
                      },
                    ),
                    BlocConsumer<EventManagementCubit, EventManagementState>(
                      listener: (context, state) {
                        if (state is EventManagementCreated) {
                          _sn("Event created");
                          Future.delayed(const Duration(seconds: 2))
                              .whenComplete(() => Navigator.of(context).pop());
                        } else if (state is EventManagementError) {
                          _sn("Failed to create Event");
                        }
                      },
                      builder: (context, state) {
                        if (state is EventManagementPerformingAction) {
                          return const EventCreationSubmitButton(
                            enabled: false,
                          );
                        } else {
                          if (state is EventManagementCreated) {
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
