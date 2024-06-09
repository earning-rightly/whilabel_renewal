


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/enums/gender.dart';
import 'package:whilabel_renewal/screen/register/register_user_info/register_user_info_state.dart';

class RegisterUserInfoViewModel extends StateNotifier<RegisterUserInfoState> {


  final provider = StateNotifierProvider<RegisterUserInfoViewModel,RegisterUserInfoState>((_) {
    return RegisterUserInfoViewModel();
  });

  RegisterUserInfoViewModel() : super(RegisterUserInfoState.initial("nickname"));




  void genderBtnTapped(Gender gender) {
    state = state.copyWith(gender: gender);

  }

  void registerBtnTapped(String name, String data) {

  }
}