import 'package:google_sign_in/google_sign_in.dart';

class GoogleOauth {
  //TODO 리턴 타입 정하기
  Future<dynamic> login() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print(googleUser);
      print("Google Oauth 성공");
      return googleUser;
    }
    return;
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
  }
}