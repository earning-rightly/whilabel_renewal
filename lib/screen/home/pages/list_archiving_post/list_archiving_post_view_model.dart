import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/sort_button_state.dart';
import 'package:whilabel_renewal/enums/list_sort_button_order.dart';

import './list_archiving_post_state.dart';

class ListArchivingPostViewModel extends StateNotifier<ListArchivingPostState> {
  final provider =
      StateNotifierProvider<ListArchivingPostViewModel, ListArchivingPostState>(
          (ref) => ListArchivingPostViewModel());

  ListArchivingPostViewModel()
      : super(
            ListArchivingPostState.initial());

 void selectSortingButton(ListSortingButtonType buttonType){

   final  listSortingButtons  = ListSortingButtonType.values.map((value) {
     bool isSelected = false;
     if (value == buttonType) {
       isSelected = true;
     }

     return SortButtonState(buttonOrder: value, isSelected: isSelected);
   }).toList();

   state = state.copyWith(buttonStates: listSortingButtons);
 }
}
