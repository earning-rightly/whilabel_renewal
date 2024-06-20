import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/data/whilabel_menu_item.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

class ContextMenuItem extends StatelessWidget {
  final WhilabelMenuItem whilabelMenuItem;

  final bool bottomBorder;
  final TextStyle? textStyle;

  const ContextMenuItem(
      {Key? key, required this.whilabelMenuItem, this.bottomBorder = true, this.textStyle})
      : super(key: key);

  @override
  PopupMenuItem build(BuildContext context) {
    return PopupMenuItem(
      value: whilabelMenuItem.value,
      padding: EdgeInsets.zero,
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        alignment: Alignment.center,
        height: 44,
        // MenuItem 구분선
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
              color: ColorsManager.gray200, width: bottomBorder ? 0.5 : 0),
        )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              whilabelMenuItem.title,
              style: textStyle ?? TextStylesManager.regular16,
            ),
            SvgPicture.asset(
              whilabelMenuItem.iconPath,
            ),
          ],
        ),
      ),
    );
  }
}
