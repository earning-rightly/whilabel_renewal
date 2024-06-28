import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/screen/my_page/announcement/announcement_view_text.dart';

part 'announcement_state.freezed.dart';

@freezed
class AnnouncementState with _$AnnouncementState{
  const factory AnnouncementState(
      {
        required AnnouncementViewText viewText,
       }) = _AnnouncementState;

  factory AnnouncementState.initial() {
    return AnnouncementState(
       viewText: AnnouncementViewText());
  }
}



