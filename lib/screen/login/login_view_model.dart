import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/main_bottom_tab_page/main_bottom_tab_page.dart';
import 'package:whilabel_renewal/screen/register/nickname/register_nickname_view.dart';
import 'package:whilabel_renewal/service/oauth/apple_ouath.dart';
import 'package:whilabel_renewal/service/oauth/google_oauth.dart';
import 'package:whilabel_renewal/service/oauth/kakao_oauth.dart';
import 'package:whilabel_renewal/enums/login_type_enum.dart';
import 'package:whilabel_renewal/screen/login/login_view_state.dart';
import 'package:whilabel_renewal/service/user_service.dart';
import 'package:whilabel_renewal/singleton/register_singleton.dart';
import 'package:whilabel_renewal/singleton/shared_preference_singleton.dart';
import 'package:whilabel_renewal/singleton/user_singleton.dart';

class LoginViewModel extends StateNotifier<LoginViewState> {
  final userService = UserService();

  BuildContext? _context;

  final provider = StateNotifierProvider<LoginViewModel, LoginViewState>((_) {
    return LoginViewModel();
  });

  LoginViewModel() : super(LoginViewState.initial());

  void setContext(BuildContext context) {
    this._context = context;
  }

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
    _callLoginAPI(snsType, snsToken);
  }

  void _callLoginAPI(LoginType snsType, String snsToken) async {
    final (isSuccess, result) = await userService.login(snsType, snsToken);
    if (isSuccess) {
      await SharedPreferenceSingleton.instance
          .setToken(result.data?.token ?? "");
      _callUserMeApi();
    } else {
      if ((result.code ?? 0 )== 1001) { // 미가입 회원
        RegisterSingleton.instance.loginType = snsType;
        RegisterSingleton.instance.snsToken = snsToken;
        Navigator.push(_context!,
            MaterialPageRoute(builder: (context) => RegisterNicknameView()));
      }
      else if ((result.code ?? 0) == 1002 ) { //탈퇴된 회원 처리
        final message = result.message ?? "잠시 후 다시 시도해주세요";
        ScaffoldMessenger.of(_context!).showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    }
  }

  void _callUserMeApi() async {
    final (isSuccess, result) = await userService.me();

    if (isSuccess) {
      UserSingleton.instance.setUserMeResponse(result);
      Navigator.pushAndRemoveUntil(_context!,
          MaterialPageRoute(builder: (context) {
        return MainBottomTabPage();
      }), (Route<dynamic> route) => false);
    } else {
      final message = result.message ?? "잠시 후 다시 시도해주세요";
      ScaffoldMessenger.of(_context!).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}
