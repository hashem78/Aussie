import 'package:aussie/aussie_imports.dart';

class StartTimeFormField extends StatelessWidget {
  const StartTimeFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final InputFieldBloc<TimeOfDay, Object> _formElement = context
        .select<EventCreationBlocForm, InputFieldBloc<TimeOfDay, Object>>(
      (EventCreationBlocForm value) => value.timeonly1,
    );
    return TimeFieldBlocBuilder(
      timeFieldBloc: _formElement,
      format: DateFormat('hh:mm a'),
      initialTime: TimeOfDay.now(),
      decoration: InputDecoration(
        labelText: getTranslation(context, 'eventCreationStartingTimeTitle'),
        filled: true,
        border: InputBorder.none,
        hintText: getTranslation(context, 'eventCreationStartingTimeHint'),
        prefixIcon: const Icon(Icons.access_time),
      ),
    );
  }
}
