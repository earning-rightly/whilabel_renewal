import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/enums/login_type_enum.dart';
import 'package:whilabel_renewal/screen/login/login_view_state.dart';
import 'package:whilabel_renewal/screen/register/nickname/register_nickname_view.dart';


final loginViewModelProvider = StateNotifierProvider<LoginViewModel,LoginViewState> ( (ref) {
  return LoginViewModel(ref);
});
class LoginViewModel extends StateNotifier<LoginViewState> {
  final Ref ref;


  LoginViewModel(this.ref) : super(LoginViewState.initial());


  void processLogin(LoginType type) {
    state = state.copyWith(isLoading : true);

    //TODO: login API call


  }


  void showRegisterNicknameView(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterNicknameView()));
  }

}