

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_picker_state.freezed.dart';

@freezed
class DatePickerState with _$DatePickerState {
  const factory DatePickerState({
    required DateTime dateTime,
    required String dateString,
}) = _DatePickerState;


  factory DatePickerState.initial() {
    return DatePickerState(dateTime: DateTime.parse("2000-01-01"), dateString: "");
  }
}