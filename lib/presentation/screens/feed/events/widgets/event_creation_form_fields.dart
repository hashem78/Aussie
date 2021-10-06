import 'package:aussie/presentation/screens/feed/events/widgets/form/form_fields/description.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/form_fields/enddate.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/form_fields/endtime.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/form_fields/startdate.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/form_fields/starttime.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/form_fields/subtitle.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/form_fields/title.dart';
import 'package:flutter/material.dart';

class EventCreationFormFields extends StatelessWidget {
  const EventCreationFormFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const<Widget> [
        TitleFormField(),
        SubtitleFormField(),
        StartDateFormField(),
        EndDateFormField(),
        StartTimeFormField(),
        EndTimeFormField(),
        DescriptionFormField(),
      ],
    );
  }
}
