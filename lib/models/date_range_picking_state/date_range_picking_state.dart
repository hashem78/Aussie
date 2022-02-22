import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'date_range_picking_state.freezed.dart';

@freezed
class DateRangePickingState with _$DateRangePickingState {
  const factory DateRangePickingState.picked(DateTimeRange locationResult) =
      _DateRangePickingStatePicked;
  const factory DateRangePickingState.notPicked() =
      _DateRangePickingStateNotPicked;
  const factory DateRangePickingState.error() = _DateRangePickingStateError;
}
