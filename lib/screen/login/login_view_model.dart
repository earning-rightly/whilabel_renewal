import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/doamin/service/oauth/google_oauth.dart';
import 'package:whilabel_renewal/doamin/service/oauth/kakao_oauth.dart';
import 'package:whilabel_renewal/enums/login_type_enum.dart';
import 'package:whilabel_renewal/screen/login/login_view_state.dart';

class LoginViewModel extends StateNotifier<LoginViewState> {
  final provider = StateNotifierProvider<LoginViewModel, LoginViewState>((_) {
    return LoginViewModel();
  });

  LoginViewModel() : super(LoginViewState.initial());

  void processLogin(LoginType type) {
    state = state.copyWith(isLoading: true);
//TODO: login API call
    switch (type) {
      case LoginType.google:
        _mockLoginWithGoogle();
        break;
      case LoginType.kakaotalk:
        _mockLoginWithKakao();
        break;

      default:
        print("LoginType 값이 정의되지 않았습니다");
    }
  }

  Future<void> _mockLoginWithGoogle() async {
    print("login google is working ");
    // AuthUser? loginedAuthUser;
    final google= GoogleOauth();
    final user =  google.login();


  }

  Future<void> _mockLoginWithKakao() async {
    final kakao = KaKaoOauth();
    kakao.login();
  }
}
