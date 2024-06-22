

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/register/nickname/register_nickname_state.dart';
import 'package:whilabel_renewal/screen/register/register_user_info/register_user_info_view.dart';
import 'package:whilabel_renewal/service/user_service.dart';
import 'package:whilabel_renewal/singleton/register_singleton.dart';



class RegisterNicknameViewModel extends StateNotifier<RegisterNicknameState> {
  final Color _enabledNextBtnColor = ColorsManager.orange;
  final Color _enabledNextBtnTitleColor = ColorsManager.white;
  final Color _disabledNextBtnColor = ColorsManager.black300;
  final Color _disabledNextBtnTitleColor = ColorsManager.gray;
  final userService = UserService();

  final registerNicknameProvider = StateNotifierProvider<RegisterNicknameViewModel, RegisterNicknameState>((ref) {
    return RegisterNicknameViewModel();
  });

  RegisterNicknameViewModel() : super(RegisterNicknameState.initial());


  void validateNickname(String nickname) {
    if (nickname.length < 2 || nickname.length > 20 ) {
      state = state.copyWith(isNextBtnEnabled: false,
          errorInfoText: "닉네임은 최소 3글자 최대 20자 내외여야 합니다.",
          nextBtnColor: _disabledNextBtnColor,
          nextBtnTitleColor: _disabledNextBtnTitleColor);
    }
    else {
      state = state.copyWith(isNextBtnEnabled: true,
          errorInfoText: null,
          nextBtnColor: _enabledNextBtnColor,
          nextBtnTitleColor: _enabledNextBtnTitleColor);
    }
  }

  void checkDuplicatedNickname(BuildContext context, String nickname) async {
    //TODO: api
    final result = await userService.checkNickname(nickname);
    if (result.$1) {
      RegisterSingleton.instance.nickname = nickname;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RegisterUserInfoView()));
    }
    else {
      final message = result.$2.message ?? "잠시 후 다시 시도해주세요";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}
