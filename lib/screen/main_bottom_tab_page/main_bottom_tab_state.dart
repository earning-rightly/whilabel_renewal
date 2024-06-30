
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_bottom_tab_state.freezed.dart';

@freezed
class MainBottomTabState with _$MainBottomTabState {
  const factory MainBottomTabState({
    required int currentIndex,
  }) = _MainBottomTabState;

  factory MainBottomTabState.initial() {
    return MainBottomTabState(currentIndex: 0);
  }
}
