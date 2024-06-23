

import 'package:http/http.dart';
import 'package:whilabel_renewal/singleton/shared_preference_singleton.dart';

class BaseService {
  final baseUrl = "172.30.1.70:8080";

  Future<Map<String,String>> getAuthenticateHeader() async {
    final token = await SharedPreferenceSingleton.instance.getToken();

    return {"Authorization" : "Bearer ${token}", "Content-Type" : "application/json"};
  }
}