import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whilabel_renewal/design_guide_managers/base_design_settings.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

class CommonPopUpWithTwoButtons extends StatelessWidget {
  final String title;
  final String contents;
  final String leftButtonTitle;
  final String rightButtonTitle;

  final Color rightButtonColor;
  final Color leftButtonColor;

  final Function()? onClickLeftButton;
  final Function()? onClickRightButton;

  final Function(BuildContext context) popFunction = (context) {
    Navigator.of(context).pop();
  };

  CommonPopUpWithTwoButtons(
      {super.key,
      required this.title,
      this.contents = "",
      this.leftButtonTitle = "취소",
      this.rightButtonTitle = "승인",
      this.rightButtonColor = ColorsManager.red,
      this.leftButtonColor = ColorsManager.black300,
      this.onClickLeftButton,
      this.onClickRightButton});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      // 디폴트 값이 존재하므로 0으로 만들어서 넗혀주기
      insetPadding: const EdgeInsets.symmetric(horizontal: 5),
      backgroundColor: ColorsManager.black200,
      title: SizedBox(
        width: screenWidth - 32,
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),

      titleTextStyle: TextStylesManager.bold16,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(BaseRadius.radius16))),

      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: _PopUpButton(
                  title: leftButtonTitle,
                  color: leftButtonColor,
                  onClick: onClickLeftButton ?? popFunction(context)),
            ),
            Expanded(
              flex: 1,
              child: _PopUpButton(
                  title: rightButtonTitle,
                  color: rightButtonColor,
                  onClick: onClickRightButton ?? popFunction(context)),
            ),
          ],
        )
      ],
    );
  }
}

class _PopUpButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function() onClick;

  const _PopUpButton(
      {super.key,
      required this.title,
      required this.color,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 15, right: 5),
      child: OutlinedButton(
        onPressed: onClick,
        style: OutlinedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: ColorsManager.gray500,
          fixedSize: const Size(120, 50),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BaseRadius.radius12)),
          side: const BorderSide(
            width: 1.0,
            color: ColorsManager.black200,
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
