import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_view_state.freezed.dart';

@freezed
class SettingViewState with _$SettingViewState {
  /** TODO) 필오한 state가 무엇일까?*/
  const factory SettingViewState({
    required SettingViewText settingViewText,
    required bool isAblePushNotification,
    required bool isAbleMarketingNotification,
  }) = _SettingViewState;

  factory SettingViewState.initial(
      bool _isAblePushNotification, bool _isAbleMarketingNotification) {

    return SettingViewState(
      settingViewText: SettingViewText(),
        isAblePushNotification: _isAblePushNotification,
        isAbleMarketingNotification: _isAbleMarketingNotification);
  }
}

class SettingViewText {
  final String logOutText = "로그아웃";
  final String signOutText = "회원탈퇴";
  final String pushAlimText = "푸쉬 알림";
  final String marketingAlimText = "마케팅 정보 알림";
}

