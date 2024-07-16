import 'dart:async';
import 'package:flutter/material.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/common_views/common_pop_up_with_two_buttons.dart';
import 'package:whilabel_renewal/screen/common_views/long_text_button.dart';
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MainBottomTabPage(),
          ), (Route<dynamic> route) => false
        );
      },
      onClickLeftButton: () {
        Navigator.pop(context);
      },
    ),
  );
}



void showSimpleDialog(
    BuildContext context, String title, String subTitle,    { Function()? onClickOktButton }
) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        backgroundColor: ColorsManager.black200,
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        contentPadding:
        const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStylesManager.bold20,
                ),
                const SizedBox(height: 20),
                Text(subTitle,
                    textAlign: TextAlign.center,
                    style: TextStylesManager.regular16.copyWith(color: ColorsManager.gray)),
                const SizedBox(height: 30),
                LongTextButton(
                  buttonText: "확인",
                  enabled: true,
                  color: ColorsManager.brown100,
                  onPressedFunc: onClickOktButton ?? (){Navigator.pop(context);} ,
                ),
              ],
            ),
          )
        ],
      );
    },
  );

}