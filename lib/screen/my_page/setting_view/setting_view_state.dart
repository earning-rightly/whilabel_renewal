import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_view_state.freezed.dart';

@freezed
class SettingViewState with _$SettingViewState {
  /** TODO) 필오한 state가 무엇일까?*/
  const factory SettingViewState({
    required SettingViewText settingViewText,
    required bool isAblePushAlim,
    required bool isAbleMarketingAlim,
  }) = _SettingViewState;

  factory SettingViewState.initial(
      bool _isAblePushAlim, bool _isAbleMarketingAlim) {

    return SettingViewState(
      settingViewText: SettingViewText(),
        isAblePushAlim: _isAblePushAlim,
        isAbleMarketingAlim: _isAbleMarketingAlim);
  }
}

class SettingViewText {
  final String logOutText = "로그아웃";
  final String signOutText = "회원탈퇴";
  final String pushAlimText = "푸쉬 알림";
  final String marketingAlimText = "마케팅 정보 알림";
}

