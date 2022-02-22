import 'package:aussie/aussie_imports.dart';
import 'package:aussie/models/date_range_picking_state/date_range_picking_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DateRangePickingNotifier extends StateNotifier<DateRangePickingState> {
  DateRangePickingNotifier() : super(const DateRangePickingState.notPicked());
  void pick(DateTimeRange? newLoc) {
    if (newLoc != null) {
      state = DateRangePickingState.picked(newLoc);
    } else {
      state = const DateRangePickingState.error();
    }
  }

  bool validate() {
    return state.when(
      picked: (_) => true,
      notPicked: () {
        state = const DateRangePickingState.error();
        return false;
      },
      error: () {
        state = const DateRangePickingState.error();
        return false;
      },
    );
  }
}

final dateRangeProvider = StateNotifierProvider.autoDispose<
    DateRangePickingNotifier, DateRangePickingState>(
  (_) {
    return DateRangePickingNotifier();
  },
);
