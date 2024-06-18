import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'my_page_state.dart';

class MyPageViewModel extends StateNotifier<MyPageState> {
  final provider = StateNotifierProvider<MyPageViewModel, MyPageState>((ref) {
    return MyPageViewModel();
  });

  MyPageViewModel() : super(MyPageState.initial());
}
