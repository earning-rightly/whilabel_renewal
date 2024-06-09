import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/util_views/loading_view/loading_view_state.dart';


final loadingViewModelProvider = StateNotifierProvider<LoadingViewModel,LoadingViewState>( (ref) {
  return LoadingViewModel(ref);
});

class LoadingViewModel extends StateNotifier<LoadingViewState> {
  final Ref ref;


  LoadingViewModel(this.ref) : super(LoadingViewState.initial());

  void showLoading() {
    if (state.isLoading == true) {
      return;
    }
    state = state.copyWith(isLoading : true);
  }

  void hideLoading() {
    if (state.isLoading == false) {
      return;
    }
    state = state.copyWith(isLoading : false);
  }
}