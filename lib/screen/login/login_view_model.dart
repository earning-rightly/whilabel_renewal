import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/enums/login_type_enum.dart';
import 'package:whilabel_renewal/screen/login/login_view_state.dart';



class LoginViewModel extends StateNotifier<LoginViewState> {

  final provider = StateNotifierProvider<LoginViewModel,LoginViewState> ( (_) {
    return LoginViewModel();
  });

  LoginViewModel() : super(LoginViewState.initial());


  void processLogin(LoginType type) {
    state = state.copyWith(isLoading : true);

    //TODO: login API call


  }


}