import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/data/menu_item.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';

part 'context_menu_state.freezed.dart';

@freezed
class ContextMenuState with _$ContextMenuState {
  const factory ContextMenuState(
      {required List<WhilabelMenuItem> meunItemContent}) = _ContextMenuState;

  factory ContextMenuState.initial() {

    List<WhilabelMenuItem> meunItemContent = [
      WhilabelMenuItem(
          title: "공유하기", iconPath: SvgIconPath.share, value: "share"),
      WhilabelMenuItem(
          title: "수정하기", iconPath: SvgIconPath.modify, value: "modify"),
      WhilabelMenuItem(
          title: "삭제하기", iconPath: SvgIconPath.delete, value: "delete")
    ];
    return ContextMenuState(meunItemContent: meunItemContent);
  }
}

