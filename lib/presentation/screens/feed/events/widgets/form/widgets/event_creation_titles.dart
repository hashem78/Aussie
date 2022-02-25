
import 'package:aussie/presentation/screens/feed/events/widgets/form/widgets/event_creation_section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EventCreationTitles extends StatelessWidget {
  const EventCreationTitles({
    Key? key,
    required this.titleController,
    required this.subtitileController,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController subtitileController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EventCreationSectionTitle(
          text: 'Titles',
          iconData: Icons.title,
        ),
        SizedBox(
          height: .02.sh,
        ),
        TextFormField(
          controller: titleController,
          autovalidateMode: AutovalidateMode.always,
          decoration: const InputDecoration(
            labelText: 'Title',
            prefixIcon: Icon(Icons.text_fields),
          ),
          validator: (val) => MultiValidator(
            [
              RequiredValidator(errorText: 'This field is required'),
              MinLengthValidator(
                10,
                errorText: 'Title has to be a tleast 10 characters long',
              ),
            ],
          ).call(val),
        ),
        SizedBox(height: 0.02.sh),
        TextFormField(
          controller: subtitileController,
          autovalidateMode: AutovalidateMode.always,
          decoration: const InputDecoration(
            labelText: 'Sub title',
            prefixIcon: Icon(Icons.text_fields),
          ),
          validator: (val) => MultiValidator(
            [
              RequiredValidator(errorText: 'This field is required'),
              MinLengthValidator(
                10,
                errorText: 'Sub title has to be at least 10 characters long',
              ),
            ],
          ).call(val),
        ),
      ],
    );
  }
}