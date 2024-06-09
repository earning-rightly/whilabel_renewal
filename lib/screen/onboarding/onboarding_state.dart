

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/screen/onboarding/onboarding_text.dart';

part 'onboarding_state.freezed.dart';
@freezed
class OnBoardingState with _$OnBoardingState {
  const factory OnBoardingState({
    required String title,
    required String btnTitle,
    required num target,
}) = _OnBoardingState;

  factory OnBoardingState.initial(String title, String btnTitle) {
    return OnBoardingState(title: title, btnTitle: btnTitle, target: 0.5);
  }
}