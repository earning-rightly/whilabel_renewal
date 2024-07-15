
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/main_bottom_tab_page/main_bottom_tab_state.dart';
import 'package:whilabel_renewal/singleton/gallery_singleton.dart';


class MainBottomTabViewModel extends StateNotifier<MainBottomTabState>  {

  MainBottomTabViewModel() : super(MainBottomTabState.initial());

  final provider = StateNotifierProvider<MainBottomTabViewModel,MainBottomTabState>( (ref) {
    return MainBottomTabViewModel();
  });


  void setCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

}