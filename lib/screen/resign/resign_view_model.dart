import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/common_views/common_pop_up_with_two_buttons.dart';
import 'package:whilabel_renewal/screen/resign/resign_view_state.dart';



///viewmodel provider
final resignViewModelProvider =
StateNotifierProvider<ResignViewModel,ResignViewState>( (ref) {
  return ResignViewModel(ref);
});

class ResignViewModel extends StateNotifier<ResignViewState> {
  final Ref ref;
  ResignViewModel(this.ref) : super(ResignViewState.initial());



  void showResignConfirmPopUp(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return CommonPopUpWithTwoButtons(title: "정말 탈퇴하시겠어요?",
      rightButtonTitle: "탈퇴하기",
      onClickLeftButton: () {
        Navigator.of(context).pop();
      },
      onClickRightButton: () {
        //TODO: 나중에 api 받아서 처리
        Navigator.of(context).pop();
      });
    });
  }

}