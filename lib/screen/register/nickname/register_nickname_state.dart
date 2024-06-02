import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/register/nickname/register_nickname_text.dart';

part 'register_nickname_state.freezed.dart';

@freezed
class RegisterNicknameState with _$RegisterNicknameState {
  const factory RegisterNicknameState({
    required RegisterNicknameText texts,
    required bool isNextBtnEnabled,
    required bool isLoading,
    required String? errorInfoText,
    required Color nextBtnColor,
    required Color nextBtnTitleColor
}) = _RegisterNicknameState;


  factory RegisterNicknameState.initial() {
    return RegisterNicknameState(texts: RegisterNicknameText(),
        isNextBtnEnabled: false,
        isLoading: false,
        errorInfoText: null,
        nextBtnColor: ColorsManager.black300,
        nextBtnTitleColor: ColorsManager.gray);
  }
}