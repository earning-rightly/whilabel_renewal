import 'package:flutter/cupertino.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';


class AppleOauth {
  Future<void> login() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print('identityToken: ${credential.identityToken}');
      print(credential);
    }catch(err){
      debugPrint("에러 발생");
      debugPrint('$err');
    }
  }
}