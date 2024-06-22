
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_state.dart';

class MainViewModel extends StateNotifier<MainState>  {

  MainViewModel() : super(MainState.initial());

  final provider = StateNotifierProvider<MainViewModel,MainState>( (ref) {
    return MainViewModel();
  });


  void setCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

}