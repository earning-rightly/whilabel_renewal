import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

class ToggleSwitchButton extends StatelessWidget {
  const ToggleSwitchButton(
      {super.key,
      required this.title,
      required this.isButtonState,
      required this.onPressedButton});
  final Function onPressedButton;
  final String title;
  final bool isButtonState;

  /*TODO) 버튼 상태를 부모에게 받아와서 상태를 변화 시켜주자 **/
  final String offToggleIconPath = "assets/icon/toggle_off.svg";
  final String onToggleIconPath = "assets/icon/toggle_on.svg";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStylesManager.createHadColorTextStyle(
                "M16",
                ColorsManager.gray200,
              )),
          IconButton(
            iconSize: 60,
            onPressed: () {
              onPressedButton();
            },
            icon: SvgPicture.asset(
                isButtonState == true ? onToggleIconPath : offToggleIconPath),
          )
        ],
      ),
    );
  }
}
