import 'package:flutter/material.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

// ignore: must_be_immutable
class LongTextButton extends StatelessWidget {
  final String buttonText;
  final Color buttonTextColor;
  final TextStyle? buttonTextStyle;
  final Function()? onPressedFunc;
  final bool? enabled;
  final Function()? onPressedFuncWhenDisabled;
  final Color color;
  final Color borderColor;
  final double height;
  final double width;
  final ButtonStyle? buttonStyle;

  LongTextButton({
    super.key,
    required this.buttonText,
    this.onPressedFunc,
    this.onPressedFuncWhenDisabled,
    this.color = Colors.black,
    this.borderColor = Colors.black,
    this.buttonTextColor = Colors.white,
    this.enabled = true,
    this.height = 50,
    this.width = double.infinity,
    this.buttonTextStyle,
    this.buttonStyle,
  });

  double btnRadius = 12;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      height: 52,
      width: width,
      child: TextButton(
        onPressed: (enabled == false) ? null : onPressedFunc,
        style: buttonStyle ??
            OutlinedButton.styleFrom(
              fixedSize: Size(width, 40),
              elevation: 0,
              foregroundColor: ColorsManager.white,
              // 활성화 시 글자색
              backgroundColor: color,
              // 활성화 시 배경색
              disabledForegroundColor: ColorsManager.gray,
              // 비활성화 시 글자색 todo 미정
              disabledBackgroundColor: ColorsManager.gray300,
              // 비활성화 시 배경색
              shape: RoundedRectangleBorder(
                side: BorderSide(  width: 0.5,
                  color: borderColor, ),
                borderRadius: BorderRadius.all(Radius.circular(btnRadius)),
              ),

              textStyle: TextStylesManager.bold16,
            ),
        child: Text(
          buttonText,
          style: buttonTextStyle ?? TextStyle(color: buttonTextColor),
        ),
      ),
    );
  }
}
