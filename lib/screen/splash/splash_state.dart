


import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState() = _SplashState;

  factory SplashState.initial() {
    return SplashState();
  }
}