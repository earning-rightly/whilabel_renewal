import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/common_views/common_pop_up_with_two_buttons.dart';
import 'package:whilabel_renewal/service/user_service.dart';

import '../../../../singleton/shared_preference_singleton.dart';
import '../../../../singleton/user_singleton.dart';
import '../../../route/routes.dart';
import 'setting_view_state.dart';

class SettingViewModel extends StateNotifier<SettingViewState> {


  SettingViewModel() : super(SettingViewState.initial(false, false));


  final provider =
  StateNotifierProvider<SettingViewModel, SettingViewState>(
          (ref) => SettingViewModel());


  final _userService = UserService();
  BuildContext? _context;


  void setBuildContext(BuildContext context) {
    _context = context;
  }


  void updatePushNotificationState(bool state) async {
    final user = UserSingleton.instance.getUserMeResponse();
    if (user == null) {
      return;
    }
    final isSuccess = await _userService.setPushAllow(user.isMarketingAllowed, !state);

    if (isSuccess) {
      _callUserMeApi();
    }

    this.state = this.state.copyWith(
          isAblePushNotification: !state,
        );
  }

  Future<void> updateMarketingNotificationState(bool state) async {
    final user = UserSingleton.instance.getUserMeResponse();
    if (user == null) {
      return;
    }
    final isSuccess = await _userService.setPushAllow(!state, user.isPushAllowed);

    if (isSuccess) {
      _callUserMeApi();
    }

    this.state = this.state.copyWith(
      isAbleMarketingNotification: !state,
    );
  }

  void _callUserMeApi() async {
    final (isSuccess, result) = await _userService.me();

    if (isSuccess) {
      UserSingleton.instance.setUserMeResponse(result);
    } else {
      final message = result.message ?? "잠시 후 다시 시도해주세요";
      ScaffoldMessenger.of(_context!).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
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
              onClickRightButton: () async {
                UserSingleton.instance.setUserMeResponse(null);
                await SharedPreferenceSingleton.instance.setToken("");
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, Routes.login);
              });
        });
  }
}
