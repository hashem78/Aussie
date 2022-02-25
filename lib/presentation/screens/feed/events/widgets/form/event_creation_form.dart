import 'package:aussie/presentation/screens/feed/events/widgets/form/widgets/event_creation_banner_picker.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/widgets/event_creation_date_range_section.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/widgets/event_creation_description.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/widgets/event_creation_gallery_picker.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/widgets/event_creation_location_picker.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/widgets/event_creation_submition_button.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/widgets/event_creation_titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

var eventCreationFormKey = GlobalKey<FormState>();

class EventCreationForm extends HookConsumerWidget {
  const EventCreationForm({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final subtitileController = useTextEditingController();
    final descriptionController = useTextEditingController();

    return Form(
      key: eventCreationFormKey,
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 30,
          children: [
            const EventCreationBannerPicker(),
            const EventCreationGalleryPicker(),
            EventCreationTitles(
              titleController: titleController,
              subtitileController: subtitileController,
            ),
            EventCreationDescription(
              descriptionController: descriptionController,
            ),
            const EventCreationDateRangeSection(),
            const EventCreationLocationPicker(),
            EventCreationSubmitionButton(
              titleController: titleController,
              subtitileController: subtitileController,
              descriptionController: descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}