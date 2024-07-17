



import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/login/login_view.dart';
import 'package:whilabel_renewal/screen/splash/splash_state.dart';
import 'package:whilabel_renewal/singleton/shared_preference_singleton.dart';

import '../../service/user_service.dart';
import '../../singleton/user_singleton.dart';
import '../main_bottom_tab_page/main_bottom_tab_page.dart';

class SplashViewModel extends StateNotifier<SplashState> {
  SplashViewModel() : super(SplashState.initial());


  final provider = StateNotifierProvider<SplashViewModel,SplashState>( (_) {
    return SplashViewModel();
  });

  final userService = UserService();

  BuildContext? _context;


  void setBuildContext(BuildContext context) {
    _context = context;
  }


  void checkAutoLogin() async {
    final token = await SharedPreferenceSingleton.instance.getToken();
    debugPrint("token ${token}");
    if (token.isEmpty || token == "") {
      Navigator.pushAndRemoveUntil(_context!,
          MaterialPageRoute(builder: (context) {
            return LoginView();
          }), (Route<dynamic> route) => false);
    }
    else {
      _callUserMeApi();
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