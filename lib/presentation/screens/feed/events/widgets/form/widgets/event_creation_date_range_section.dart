import 'package:aussie/models/date_range_picking_state/date_range_picking_state.dart';
import 'package:aussie/presentation/screens/feed/events/widgets/form/widgets/event_creation_section_title.dart';
import 'package:aussie/state/date_range_picking.dart';
import 'package:aussie/util/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class EventCreationDateRangeSection extends HookConsumerWidget {
  const EventCreationDateRangeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txtCntrl1 = useTextEditingController();
    final txtCntrl2 = useTextEditingController();

    ref.listen<DateRangePickingState>(
      dateRangeProvider,
      (p, n) {
        if (n != const DateRangePickingState.notPicked() &&
            n != const DateRangePickingState.error()) {
          final formatter = DateFormat();
          txtCntrl1.text = n.whenOrNull(
            picked: (val) => formatter.format(val.start),
          )!;
          txtCntrl2.text = n.whenOrNull(
            picked: (val) => formatter.format(val.end),
          )!;
        }
      },
    );
    return GestureDetector(
      onTap: () async {
        final range = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 30),
          ),
        );
        final startingTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              helpText: 'Select Starting Time',
            ) ??
            const TimeOfDay(hour: 0, minute: 0);

        final endingTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              helpText: 'Select Ending Time',
            ) ??
            const TimeOfDay(hour: 0, minute: 0);
        if (range != null) {
          final joinedStartingDate = joinDateWithTime(
            range.start,
            startingTime,
          );
          final joinedEndingDate = joinDateWithTime(
            range.end,
            endingTime,
          );
          ref.read(dateRangeProvider.notifier).pick(
                DateTimeRange(
                  start: joinedStartingDate,
                  end: joinedEndingDate,
                ),
              );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EventCreationSectionTitle(
            text: 'Date',
            iconData: Icons.calendar_today,
          ),
          SizedBox(
            height: .02.sh,
          ),
          AbsorbPointer(
            child: TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: txtCntrl1,
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.date_range),
                labelText: 'Starting on',
              ),
              validator: (val) => RequiredValidator(
                errorText: 'This field is required',
              ).call(val),
            ),
          ),
          SizedBox(
            height: 0.03.sh,
          ),
          AbsorbPointer(
            child: TextFormField(
              controller: txtCntrl2,
              autovalidateMode: AutovalidateMode.always,
              readOnly: true,
              decoration: const InputDecoration(

                prefixIcon: Icon(Icons.date_range),
                labelText: 'Ending on',
              ),
              validator: (val) => RequiredValidator(
                errorText: 'This field is required',
              ).call(val),
            ),
          ),
        ],
      ),
    );
  }
}