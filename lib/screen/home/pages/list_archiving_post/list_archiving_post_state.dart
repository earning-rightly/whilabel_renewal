import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/data/sort_button_state.dart';
import 'package:whilabel_renewal/enums/list_sort_button_order.dart';

part 'list_archiving_post_state.freezed.dart';

@freezed
class ListArchivingPostState with _$ListArchivingPostState {
  const factory ListArchivingPostState({
    required ListSortingButtonType currentSortingOrder,
    required List<SortButtonState> buttonStates,
  }) = _ListArchivingPostState;

  factory ListArchivingPostState.initial() {
 final  listSortingButtons  = ListSortingButtonType.values.map((value) {
      bool isSelected = false;
      if (value == ListSortingButtonType.LATEST) {
        isSelected = true;
      }

      return SortButtonState(buttonOrder: value, isSelected: isSelected);
    }).toList();
    return ListArchivingPostState(
        buttonStates: listSortingButtons,
        currentSortingOrder: ListSortingButtonType.LATEST);
  }
}
