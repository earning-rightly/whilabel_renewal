import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/service/oauth/apple_ouath.dart';
import 'package:whilabel_renewal/service/oauth/google_oauth.dart';
import 'package:whilabel_renewal/service/oauth/kakao_oauth.dart';
import 'package:whilabel_renewal/enums/login_type_enum.dart';
import 'package:whilabel_renewal/screen/login/login_view_state.dart';
import 'package:whilabel_renewal/service/user_service.dart';

class LoginViewModel extends StateNotifier<LoginViewState> {
  final userService = UserService();

  final provider = StateNotifierProvider<LoginViewModel, LoginViewState>((_) {
    return LoginViewModel();
  });

  LoginViewModel() : super(LoginViewState.initial());

  void processLogin(LoginType snsType) async {
    String snsToken = "";

    switch (snsType) {
      case LoginType.kakaotalk:
        {
          snsToken = await KaKaoOauth().login();
        }
      case LoginType.google:
        {
          snsToken = await GoogleOauth().login();
        }
      case LoginType.apple:
        {
          snsToken = await AppleOauth().login();
        }
      case _:
        {}
    }

    debugPrint("accessToken 2 ${snsToken}");
    _callLoginAPI(snsType, snsToken);
  }

  void _callLoginAPI(LoginType snsType, String snsToken) async {
    final result = await userService.login(snsType, snsToken);
    debugPrint("${result}");
    if (result.$1) {
      //TODO: callUserMe api
    }
    else {
      //TODO: -goto nickname page
    }
  }
}
