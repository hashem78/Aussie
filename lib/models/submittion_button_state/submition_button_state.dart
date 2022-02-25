import 'package:freezed_annotation/freezed_annotation.dart';
part 'submition_button_state.freezed.dart';
@freezed
class SubmitionButtonState with _$SubmitionButtonState {
  const factory SubmitionButtonState.inital() = _SubmitionButtonInitial;
  const factory SubmitionButtonState.submitting() = _SubmitionButtonSubmitting;
  const factory SubmitionButtonState.error() = _SubmitionButtonError;
}
