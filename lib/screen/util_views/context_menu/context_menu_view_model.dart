import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/data/whilabel_menu_item.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

import './context_menu_state.dart';

class ContextMenuViewModel extends StateNotifier<ContextMenuState> {
  final provider =
      StateNotifierProvider<ContextMenuViewModel, ContextMenuState>(
          (ref) => ContextMenuViewModel());

  ContextMenuViewModel() : super(ContextMenuState.initial());

  void showContextMenu(BuildContext context, double left, double top,
      {bool bottomBorder = true, TextStyle? textStyle}) {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();
    showMenu(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      color: ColorsManager.black400,
      constraints: BoxConstraints(
        minWidth: 250, maxWidth: 274,
      ),
      position: RelativeRect.fromRect(
          Rect.fromLTWH(left, top, 30, 30),
          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
              overlay.paintBounds.size.height)),
      items: <PopupMenuItem>[
        for (WhilabelMenuItem whilabelMenuItem in state.meunItemContent)
          PopupMenuItem(
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
                    color: ColorsManager.gray200,
                    width: bottomBorder ? 0.5 : 0),
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
          )
      ],
    );
  }
}
