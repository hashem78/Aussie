import 'package:aussie/presentation/screens/feed/events/widgets/form/widgets/event_creation_section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EventCreationDescription extends StatelessWidget {
  const EventCreationDescription({
    Key? key,
    required this.descriptionController,
  }) : super(key: key);

  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const EventCreationSectionTitle(
          text: 'Description',
          iconData: Icons.description,
        ),
        SizedBox(
          height: .02.sh,
        ),
        SizedBox(
          height: .3.sh,
          child: TextFormField(
            controller: descriptionController,
            autovalidateMode: AutovalidateMode.always,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            expands: true,

            validator: (val) => MultiValidator(
              [
                RequiredValidator(errorText: 'This field is required'),
                MinLengthValidator(
                  100,
                  errorText:
                      'Your Description has to be at least 100 characters long',
                ),
                MaxLengthValidator(
                  500,
                  errorText:
                      'Your Description has to be less than 500 characters long',
                ),
              ],
            ).call(val),
          ),
        ),
      ],
    );
  }
}