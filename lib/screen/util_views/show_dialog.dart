import 'package:flutter/material.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/common_views/common_pop_up_with_two_buttons.dart';
import 'package:whilabel_renewal/screen/main_bottom_tab_page/main_bottom_tab_page.dart';

void showMoveRootDialog(BuildContext context,
    {int rootIndex = 0, String title = "홈으로 돌아기시겠습니까?"}) {
  showDialog(
    context: context,
    // 주의) builder parameter에 있는 context 객체를 사용하면 Provider 객체를 불러올 수 없음.
    builder: (BuildContext _) => CommonPopUpWithTwoButtons(
      title: title,
      leftButtonTitle: "취소",
      rightButtonTitle: "네",
      rightButtonColor: ColorsManager.brown100,
      onClickRightButton: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainBottomTabPage(),
          ),
        );
      },
      onClickLeftButton: () {
        Navigator.pop(context);
      },
    ),
  );
}
