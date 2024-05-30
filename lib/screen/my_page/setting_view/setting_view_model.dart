import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/common_views/common_pop_up_with_two_buttons.dart';

import './setting_view_state.dart';

final settingViewProvider =
    StateNotifierProvider<SettingViewModel, SettingViewState>(
        (ref) => SettingViewModel(ref));

class SettingViewModel extends StateNotifier<SettingViewState> {
  final Ref ref;

  /* TODO)
      1.User info 받아오는 로직
      2. 푸쉬 알림, 마케팅 알림 정보를 .inital에 보내주자
      **/
  SettingViewModel(this.ref) : super(SettingViewState.initial(false, false));

  Future<void> updatePushAlimState(bool alimState) async {
    /* TODO
    1. web(DB) 값 변경
    2. 변경된 값 불러오고 저장
    3. 성공 여부 return
    **/

    print("DB update 요청");
    print("GET USER 정보 ");
  }

  Future<void> updateMarketingAlimState(bool alimState) async {
    // TODO updatePushAlimState()와 동일한 순서
  }

  void showPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CommonPopUpWithTwoButtons(
              title: "정말 탈퇴하시겠어요?",
              rightButtonTitle: "로그아웃",
              onClickLeftButton: () {
                Navigator.of(context).pop();
              },
              rightButtonColor: ColorsManager.orange,
              onClickRightButton: () {
                //TODO: 나중에 api 받아서 처리
                Navigator.of(context).pop();
              });
        });
  }
}
