


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/domain/userme_response.dart';
import 'package:whilabel_renewal/singleton/user_singleton.dart';

part 'main_state.freezed.dart';

@freezed
class MainState with _$MainState {
  const factory MainState({
    required MainViewText text,
    required bool hasNotification,
    required int whiskyCount,
    required int currentIndex,
  }) = _MainState;

  factory MainState.initial() {
    return MainState(text: MainViewText(),hasNotification: false,whiskyCount: 0,currentIndex: 0);
  }
}


class MainViewText {
  final String title = "나의 위스키";
}