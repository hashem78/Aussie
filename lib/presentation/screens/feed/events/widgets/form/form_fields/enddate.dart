import 'package:aussie/aussie_imports.dart';

class EndDateFormField extends StatelessWidget {
  const EndDateFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final InputFieldBloc<DateTime, Object> _formElement =
        context.select<EventCreationBlocForm, InputFieldBloc<DateTime, Object>>(
      (EventCreationBlocForm value) {
        return value.dateAndTime2;
      },
    );
    return DateTimeFieldBlocBuilder(
      dateTimeFieldBloc: _formElement,
      format: DateFormat.yMMMMEEEEd(),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      decoration: InputDecoration(
        labelText: getTranslation(context, 'eventCreationEndDateTitle'),
        filled: true,
        border: InputBorder.none,
        prefixIcon: const Icon(Icons.date_range),
        hintText: getTranslation(context, 'eventCreationEndDateHint'),
      ),
    );
  }
}
