import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KaKaoOauth {
  Future<String> login() async {
    bool isInstalled = await isKakaoTalkInstalled();
    try {
      if (isInstalled) {
        OAuthToken oAuthToken = await UserApi.instance.loginWithKakaoTalk();
        return oAuthToken.accessToken;
      }
      else {
        OAuthToken oAuthToken = await UserApi.instance.loginWithKakaoAccount();
        return oAuthToken.accessToken;
      }
    }
    catch(error) {
      return "";
    }
  }
}