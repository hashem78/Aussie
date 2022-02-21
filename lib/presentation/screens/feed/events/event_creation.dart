import 'package:aussie/aussie_imports.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EventCreationScreen extends HookWidget {
  final Function? closeAction;

  const EventCreationScreen({Key? key, this.closeAction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
          actions: [
            IconButton(
              onPressed: () async {
                // TODO: Image picking
              },
              icon: const Icon(Icons.add),
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
