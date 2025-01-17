import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:whilabel_renewal/domain/whisky_scan_response.dart';
import 'package:whilabel_renewal/domain/whiskypost_list_response.dart';
import 'package:whilabel_renewal/domain/whiskypostdetail_response.dart';
import 'package:whilabel_renewal/service/base_service.dart';

class WhiskyService extends BaseService {
  Future<bool> postWhiskyDetailPost(
      int whiskyId,
      String imageUrl,
      double rating,
      String tasteNote,
      int bodyRate,
      int flavorRate,
      int peatRate) async {
    final body = jsonEncode({
      "whiskyId": whiskyId,
      "imageUrl": imageUrl,
      "rating": rating.toString(),
      "tasteNote": tasteNote,
      "bodyRate": bodyRate.toString(),
      "flavorRate": flavorRate.toString(),
      "peatRate": peatRate.toString()
    });

    debugPrint("${body}");
    var url = Uri.http(baseUrl, "api/v1/whisky/detail");
    final header = await super.getAuthenticateHeader();
    print(header);
    var response = await http.post(url, body: body, headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    debugPrint(response.body);

    return (isSuccess);
  }

  Future<(bool, WhiskyPostListResponse)> getListPosts(
      String sort, int page) async {
    var url = Uri.http(
        baseUrl, "api/v1/whisky/list", {"sort": sort, "page": page.toString()});

    final header = await super.getAuthenticateHeader();
    var response = await http.get(url, headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    WhiskyPostListResponse result =
        WhiskyPostListResponse.fromJson(jsonResponse);
    return (isSuccess, result);
  }

  Future<(bool, WhiskyPostListResponse)> getGridPosts(int page) async {
    var url =
        Uri.http(baseUrl, "api/v1/whisky/grid", {"page": page.toString()});

    final header = await super.getAuthenticateHeader();
    var response = await http.get(url, headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    WhiskyPostListResponse result =
        WhiskyPostListResponse.fromJson(jsonResponse);
    return (isSuccess, result);
  }

  Future<(bool, WhiskyPostDetailResponse)> getPostDetail(int postId) async {
    var url =
        Uri.http(baseUrl, "api/v1/whisky/detail", {"id": postId.toString()});

    final header = await super.getAuthenticateHeader();
    var response = await http.get(url, headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    debugPrint("${jsonResponse}");
    WhiskyPostDetailResponse result =
        WhiskyPostDetailResponse.fromJson(jsonResponse);
    return (isSuccess, result);
  }

  Future<bool> putPostDetail(int id, double rating, String tasteNote,
      double bodyRate, double flavorRate, double peatRate) async {
    final body = jsonEncode({
      "id": id.toString(),
      "rating": rating.toString(),
      "tasteNote": tasteNote,
      "bodyRate": bodyRate.toString(),
      "flavorRate": flavorRate.toString(),
      "peatRate": peatRate.toString()
    });

    debugPrint("${body}");
    var url = Uri.http(baseUrl, "api/v1/whisky/detail");
    final header = await super.getAuthenticateHeader();
    var response = await http.put(url, body: body, headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }

    return (isSuccess);
  }

  Future<(bool,WhiskyScanResponse )> getWhiskyByBarcode(String barcode) async {
    var url =
    Uri.http(baseUrl, "api/v1/whisky/scan", {"barcode": barcode});

    final header = await super.getAuthenticateHeader();
    var response = await http.get(url, headers: header);

    bool isSuccess = true;
    if (response.statusCode != 200) {
      isSuccess = false;
    }
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    WhiskyScanResponse result =
    WhiskyScanResponse.fromJson(jsonResponse);

    return (isSuccess, result);
  }
}
