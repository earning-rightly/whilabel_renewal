


import 'package:freezed_annotation/freezed_annotation.dart';

part 'loading_view_state.freezed.dart';

@freezed
class LoadingViewState with _$LoadingViewState {
  const factory LoadingViewState({
    required bool isLoading
}) = _LoadingViewState;

  factory LoadingViewState.initial() {
    return LoadingViewState(isLoading: false);
  }


}