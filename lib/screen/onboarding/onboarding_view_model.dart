import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/onboarding/onboarding_state.dart';
import 'package:whilabel_renewal/screen/onboarding/onboarding_text.dart';

import '../main_bottom_tab_page/main_bottom_tab_page.dart';

class OnBoardingViewModel extends StateNotifier<OnBoardingState> {

  int _currentStep = 1;
  BuildContext? _context;
  final OnBoardingText _texts = OnBoardingText();

  final provider = StateNotifierProvider<OnBoardingViewModel,OnBoardingState>( (_) {
    return OnBoardingViewModel();
  });

  OnBoardingViewModel() : super(OnBoardingState.initial(OnBoardingText().step1, OnBoardingText().step1BtnTitle));


  void setBuildContext(BuildContext context) {
    _context = context;
  }
  void btnTapped() {
    if (_currentStep == 1) {
      _currentStep == 2;
      state = state.copyWith(title: _texts.step2,btnTitle: _texts.step2BtnTitle,target: 1.0);
    }
    else if (_currentStep == 2) {
      Navigator.pushAndRemoveUntil(_context!,
          MaterialPageRoute(builder: (context) {
            return MainBottomTabPage();
          }), (Route<dynamic> route) => false);
    }
  }

}