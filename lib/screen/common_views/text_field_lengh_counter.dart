import 'package:flutter/material.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

class TextFieldLengthCounter extends StatelessWidget {
  final int currentLength;
  final int maxLength;
  final TextStyle? maxLengthTextStyle;
  final TextStyle? currentLengthTextStyle;

  const TextFieldLengthCounter({
    Key? key,
    required this.currentLength,
    required this.maxLength,
    this.maxLengthTextStyle,
    this.currentLengthTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          child: RichText(
            text: TextSpan(
                text: "$currentLength/",
                style: TextStylesManager.regular14,
                children: [
                  TextSpan(
                    text: "$maxLength",
                    style: TextStylesManager.createHadColorTextStyle(
                        "R14", ColorsManager.gray),
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
