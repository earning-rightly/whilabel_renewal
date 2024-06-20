import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/enums/list_sort_button_order.dart';
import 'package:whilabel_renewal/screen/home/pages/list_archiving_post/list_archiving_post_state.dart';
import 'package:whilabel_renewal/screen/home/pages/list_archiving_post/list_archiving_post_view_model.dart';

class ListSortingButton extends ConsumerWidget {
  final ListSortingButtonType sortingButtonType;
  final int index;
  final bool isSelected;
  final StateNotifierProvider<ListArchivingPostViewModel, ListArchivingPostState> listArchivingPostProvider;

  ListSortingButton( {
    super.key, // 이유없능 오류가 있기에 사용
    required this.sortingButtonType,
    required this.index,
    required this.isSelected,
  required this.listArchivingPostProvider,
  });

  // final listArchivingPostProvider = ListArchivingPostViewModel().provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listArchivingPostViewModel = ref.watch(listArchivingPostProvider.notifier);
    return OutlinedButton(
      onPressed: () {
        // print("12324");
        listArchivingPostViewModel.selectSortingButton(sortingButtonType);
      },
      style: OutlinedButton.styleFrom(
        foregroundColor:
            isSelected ? ColorsManager.black200 : Colors.transparent,
        backgroundColor:
            isSelected ? ColorsManager.black300 : Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 8),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: isSelected
                ? BorderSide(color: Colors.transparent)
                : BorderSide(color: ColorsManager.black300)),
      ),
      child: Text(sortingButtonType.displayName,
          maxLines: 1,
          style: isSelected
              ? TextStylesManager.createHadColorTextStyle(
                  "M14", ColorsManager.gray300)
              : TextStylesManager.createHadColorTextStyle(
                  "M14", ColorsManager.black300)),
    );
  }
}
