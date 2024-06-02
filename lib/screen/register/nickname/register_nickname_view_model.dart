

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/register/nickname/register_nickname_state.dart';


final registerNicknameProvider = StateNotifierProvider<RegisterNicknameViewModel, RegisterNicknameState>((ref) {
  return RegisterNicknameViewModel(ref);
});

class RegisterNicknameViewModel extends StateNotifier<RegisterNicknameState> {
  final Ref ref;
  final Color _enabledNextBtnColor = ColorsManager.orange;
  final Color _enabledNextBtnTitleColor = ColorsManager.white;
  final Color _disabledNextBtnColor = ColorsManager.black300;
  final Color _disabledNextBtnTitleColor = ColorsManager.gray;


  RegisterNicknameViewModel(this.ref) : super(RegisterNicknameState.initial());


  void validateNickname(String nickname) {
    //TODO: validate nickname and set state.errorInfoText and set btnState when it's not qualified
    //decision to make, check on client side or from server side
  }

  void checkDuplicatedNickname(BuildContext context, String nickname) {
    //TODO: api
  }

  void showRegisterUserInfo(BuildContext context) {

  }



}
