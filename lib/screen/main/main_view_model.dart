
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/domain/userme_response.dart';
import 'package:whilabel_renewal/singleton/user_singleton.dart';

import 'main_state.dart';

class MainViewModel extends StateNotifier<MainState>  {

  MainViewModel() : super(MainState.initial());

  final provider = StateNotifierProvider<MainViewModel,MainState>( (ref) {
    return MainViewModel();
  });


  void init() {
    UsermeResponse? result = UserSingleton.instance.getUserMeResponse();
    if (result != null) {
      state = state.copyWith(whiskyCount: result.whiskyCount);
    }
  }

  void setCurrentIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

}