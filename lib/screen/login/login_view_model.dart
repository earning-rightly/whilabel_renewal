import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/doamin/service/oauth/apple_ouath.dart';
import 'package:whilabel_renewal/doamin/service/oauth/google_oauth.dart';
import 'package:whilabel_renewal/doamin/service/oauth/kakao_oauth.dart';
import 'package:whilabel_renewal/enums/login_type_enum.dart';
import 'package:whilabel_renewal/screen/login/login_view_state.dart';

class LoginViewModel extends StateNotifier<LoginViewState> {
  final provider = StateNotifierProvider<LoginViewModel, LoginViewState>((_) {
    return LoginViewModel();
  });

  LoginViewModel() : super(LoginViewState.initial());

  void processLogin(LoginType type) async {
    state = state.copyWith(isLoading: true);
//TODO: login API call
    final user = await _snsLogin(type);
    print('user :$user');
    print('$type login success!');
  }

  Future<dynamic> _snsLogin(LoginType snsType) async {
    return switch (snsType) {
      LoginType.kakaotalk => await KaKaoOauth().login(),
      // LoginType.instagram => await InstargramOauth().login(),
      LoginType.google => await GoogleOauth().login(),
      LoginType.apple => await AppleOauth().login(),
      _ => null
    };
  }
}
