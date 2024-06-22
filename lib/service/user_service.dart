import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:whilabel_renewal/domain/login_response.dart';
import 'package:whilabel_renewal/domain/nicknamecheck_response.dart';
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

}