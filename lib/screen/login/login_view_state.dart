import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/screen/login/login_view.dart';
import 'package:whilabel_renewal/screen/login/login_view_text.dart';

part 'login_view_state.freezed.dart';

@freezed
class LoginViewState with _$LoginViewState {
  const factory LoginViewState(
      {required LoginViewText texts,
      required bool isLoading}) = _LoginViewState;

  factory LoginViewState.initial() {
    return LoginViewState(texts: LoginViewText(), isLoading: false);
  }
}
