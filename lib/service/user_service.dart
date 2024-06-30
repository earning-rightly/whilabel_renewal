import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:whilabel_renewal/domain/login_response.dart';
import 'package:whilabel_renewal/domain/nicknamecheck_response.dart';
import 'package:whilabel_renewal/domain/userme_response.dart';
import 'package:whilabel_renewal/enums/gender.dart';
import 'package:whilabel_renewal/service/base_service.dart';

import '../enums/login_type_enum.dart';


class UserService extends BaseService {

  Future<(bool,LoginResponse)> login(LoginType loginType, String snsToken,) async {
    var url =
    Uri.http(baseUrl,"api/v1/user/login");
    String snsType = "";
    switch (loginType) {
      case LoginType.kakaotalk: {
        snsType = "kakao";
      }
      case LoginType.google: {
        snsType = "google";
      }
      case LoginType.apple: {
        snsType = "apple";
      }
      case _: {
        snsType = "";
      }
    }
    var response = await http.post(url,body: {'snsType': snsType, 'snsToken': snsToken});
    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    LoginResponse result = LoginResponse.fromJson(jsonResponse);
    return  (isSuccess,result);
  }

  Future<(bool, NicknameCheckResponse)> checkNickname(String nickname) async {
    var url =
    Uri.http(baseUrl,"api/v1/user/nickname/check");
    final body = jsonEncode({'nickname': nickname});
    var response = await http.post(url,body: body ,headers: {"Content-type": "application/json"});

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint("${jsonResponse}");
    NicknameCheckResponse result = NicknameCheckResponse.fromJson(jsonResponse);
    return (isSuccess,result);
  }


  Future<(bool,LoginResponse)> register(String snsToken, LoginType loginType, String nickname, Gender gender, String birthday) async {
    var url =
    Uri.http(baseUrl,"api/v1/user/register");
    String snsType = "";
    switch (loginType) {
      case LoginType.kakaotalk: {
        snsType = "kakao";
      }
      case LoginType.google: {
        snsType = "google";
      }
      case LoginType.apple: {
        snsType = "apple";
      }
      case _: {
        snsType = "";
      }
    }

    final body = jsonEncode({'snsToken': snsToken, "snsType" : snsType, "nickname" : nickname, "gender" : gender.name, "birthDay" : birthday});
    var response = await http.post(url,body: body ,headers: {"Content-type": "application/json"});

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint("${jsonResponse}");
    LoginResponse result = LoginResponse.fromJson(jsonResponse);
    return (isSuccess,result);
  }


  Future<(bool,UsermeResponse)> me() async {
    var url =
    Uri.http(baseUrl,"api/v1/user/me");
    final header = await super.getAuthenticateHeader();
    var response = await http.get(url ,headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint("${jsonResponse}");
    UsermeResponse result = UsermeResponse.fromJson(jsonResponse);
    return (isSuccess,result);
  }

  Future<bool> resign() async {
    var url =
    Uri.http(baseUrl,"api/v1/user/resign");
    final header = await super.getAuthenticateHeader();
    var response = await http.put(url ,headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    return (isSuccess);
  }

  Future<bool> setPushAllow(bool isMarketingPushAllowed, bool isPushAllowed) async {
    var url =
    Uri.http(baseUrl,"api/v1/user/push");
    final header = await super.getAuthenticateHeader();
    final body = jsonEncode({
      "isMarketingPushAllowed": isMarketingPushAllowed.toString(),
      "isPushAllowed": isPushAllowed
    });
    var response = await http.put(url, body: body ,headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    return (isSuccess);
  }

}