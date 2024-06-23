import 'package:flutter/material.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';


class ModifyButton extends StatelessWidget {
  final Function()? onClickButton;
  final bool isModify;
  const ModifyButton({Key? key, this.onClickButton, required this.isModify}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: ColorsManager.black400),
      onPressed: onClickButton ?? () {},
      child: Text(
        isModify? "저장": "수정",
        style: TextStylesManager.createHadColorTextStyle(
            "R14", ColorsManager.brown100),
      ),
    );
  }
}
