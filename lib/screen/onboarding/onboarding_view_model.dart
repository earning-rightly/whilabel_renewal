import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/onboarding/onboarding_state.dart';
import 'package:whilabel_renewal/screen/onboarding/onboarding_text.dart';

class OnBoardingViewModel extends StateNotifier<OnBoardingState> {

  int _currentStep = 1;
  final OnBoardingText _texts = OnBoardingText();

  final provider = StateNotifierProvider<OnBoardingViewModel,OnBoardingState>( (_) {
    return OnBoardingViewModel();
  });

  OnBoardingViewModel() : super(OnBoardingState.initial(OnBoardingText().step1, OnBoardingText().step1BtnTitle));


  void btnTapped() {
    if (_currentStep == 1) {
      _currentStep == 2;
      state = state.copyWith(title: _texts.step2,btnTitle: _texts.step2BtnTitle,target: 1.0);
    }
    else if (_currentStep == 2) {
      //TODO: show nextPage
    }
  }

}