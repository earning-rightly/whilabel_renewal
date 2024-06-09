

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/screen/register/register_user_info/register_user_info_text.dart';
import '../../../enums/gender.dart';

part 'register_user_info_state.freezed.dart';

@freezed
class RegisterUserInfoState with _$RegisterUserInfoState {
  const factory RegisterUserInfoState({ 
    required RegisterUserInfoText texts ,
    required Gender gender
}) = _RegisterUserInfoState;
  
  factory RegisterUserInfoState.initial(String nickname) { 
    final texts = RegisterUserInfoText(greetingLabel: "${nickname}님에 대해\n조그만 더 알려주세요");
    return RegisterUserInfoState(texts: texts, gender: Gender.male);
  }
}