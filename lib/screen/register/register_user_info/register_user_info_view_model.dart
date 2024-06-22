


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/enums/gender.dart';
import 'package:whilabel_renewal/screen/onboarding/onboarding_view.dart';
import 'package:whilabel_renewal/screen/register/register_user_info/register_user_info_state.dart';
import 'package:whilabel_renewal/service/user_service.dart';
import 'package:whilabel_renewal/singleton/register_singleton.dart';
import 'package:whilabel_renewal/singleton/shared_preference_singleton.dart';

class RegisterUserInfoViewModel extends StateNotifier<RegisterUserInfoState> {

  final userService = UserService();

  final provider = StateNotifierProvider<RegisterUserInfoViewModel,RegisterUserInfoState>((_) {
    return RegisterUserInfoViewModel();
  });

  RegisterUserInfoViewModel() : super(RegisterUserInfoState.initial("nickname"));

  BuildContext? _context;

  void setContext(BuildContext context) {
    this._context = context;
  }


  void genderBtnTapped(Gender gender) {
    state = state.copyWith(gender: gender);

  }

  void registerBtnTapped(String name, String birthday) async {
    final snsToken = RegisterSingleton.instance.snsToken;
    final loginType = RegisterSingleton.instance.loginType;
    final nickname = RegisterSingleton.instance.nickname;
    debugPrint("birthDay ${birthday}");
    final (isSuccess, result) = await userService.register(snsToken, loginType, nickname, state.gender, birthday);

    if (isSuccess) {
      SharedPreferenceSingleton.instance.setToken(result.data?.token ?? "");
      Navigator.push(_context!,
        MaterialPageRoute(builder: (context) => OnBoardingView())
      );
    }
    else {
      final message = result.message ?? "잠시 후 다시 시도해주세요";
      ScaffoldMessenger.of(_context!).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }

  }
}