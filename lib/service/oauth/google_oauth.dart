import 'package:google_sign_in/google_sign_in.dart';

class GoogleOauth {
  Future<String> login() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    return googleAuth?.accessToken ?? "";
  }

}