
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:whilabel_renewal/domain/whiskypost_list_response.dart';
import 'package:whilabel_renewal/domain/whiskypostdetail_response.dart';
import 'package:whilabel_renewal/service/base_service.dart';

class WhiskyService extends BaseService {

  Future<(bool,WhiskyPostListResponse)> getListPosts(String sort, int page) async {
    var url =
    Uri.http(baseUrl,"api/v1/whisky/list",{"sort" : sort, "page" : page.toString()});

    final header = await super.getAuthenticateHeader();
    var response = await http.get(url,headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    WhiskyPostListResponse result = WhiskyPostListResponse.fromJson(jsonResponse);
    return  (isSuccess,result);
  }

  Future<(bool,WhiskyPostListResponse)> getGridPosts(int page) async {
    var url =
    Uri.http(baseUrl,"api/v1/whisky/grid",{"page" : page.toString()});

    final header = await super.getAuthenticateHeader();
    var response = await http.get(url,headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    WhiskyPostListResponse result = WhiskyPostListResponse.fromJson(jsonResponse);
    return  (isSuccess,result);
  }


  Future<(bool,WhiskyPostDetailResponse)> getPostDetail(int postId) async {
    var url =
    Uri.http(baseUrl,"api/v1/whisky/detail",{"id" : postId.toString()});

    final header = await super.getAuthenticateHeader();
    var response = await http.get(url,headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint("${jsonResponse}");
    WhiskyPostDetailResponse result = WhiskyPostDetailResponse.fromJson(jsonResponse);
    return  (isSuccess,result);

  }

}