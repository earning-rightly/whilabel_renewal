import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/common_views/common_pop_up_with_two_buttons.dart';
import 'package:whilabel_renewal/service/user_service.dart';
import 'package:whilabel_renewal/singleton/shared_preference_singleton.dart';
import 'package:whilabel_renewal/singleton/user_singleton.dart';

import '../../../route/routes.dart';
import './resign_view_state.dart';


class ResignViewModel extends StateNotifier<ResignViewState> {

  ResignViewModel() : super(ResignViewState.initial());

  BuildContext? _context;

  final _userService = UserService();

  final provider = StateNotifierProvider<ResignViewModel,ResignViewState>( (_) {
  return ResignViewModel();
  });


  void setBuildContext(BuildContext context) {
    _context = context;
  }

  void showResignConfirmPopUp(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return CommonPopUpWithTwoButtons(title: "정말 탈퇴하시겠어요?",
      rightButtonTitle: "탈퇴하기",
      onClickLeftButton: () {
        Navigator.of(context).pop();
      },
      onClickRightButton: () {
        _callResignAPI();
      });
    });
  }


  void _callResignAPI() async {
    final isSuccess = await _userService.resign();


    if (isSuccess) {
      UserSingleton.instance.setUserMeResponse(null);
      await SharedPreferenceSingleton.instance.setToken("");
      Navigator.of(_context!).pop();
      Navigator.pushReplacementNamed(_context!, Routes.login);
    }
  }
}