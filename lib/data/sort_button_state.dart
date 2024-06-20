
import 'package:whilabel_renewal/enums/list_sort_button_order.dart';

class SortButtonState{

  SortButtonState(
      {required this.isSelected, required this.buttonOrder, });

  bool isSelected;
  ListSortingButtonType buttonOrder;
}