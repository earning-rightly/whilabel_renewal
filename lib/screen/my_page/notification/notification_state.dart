import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/screen/my_page/announcement/announcement_view_text.dart';

import 'notification_view_text.dart';

part 'notification_state.freezed.dart';

@freezed
class NotificationState with _$NotificationState{
  const factory NotificationState(
      {
        required NotificationViewText viewText,
       }) = _NotificationState;

  factory NotificationState.initial() {
    return NotificationState(
       viewText: NotificationViewText());
  }
}



