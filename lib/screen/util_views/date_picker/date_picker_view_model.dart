


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whilabel_renewal/screen/util_views/date_picker/date_picker_state.dart';

class DatePickerViewModel extends StateNotifier<DatePickerState> {

  String _dateString = "";

  final provider = StateNotifierProvider<DatePickerViewModel,DatePickerState>( (_) {
    return DatePickerViewModel();
  });


  DatePickerViewModel(): super(DatePickerState.initial());

  void updateDate(String date) {
    state = state.copyWith(dateString: date);
  }

  void updateDateTime(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    _dateString = formattedDate;
    state = state.copyWith(dateTime: date,dateString: formattedDate);
  }

  String getResult() {
    return _dateString;
  }


}