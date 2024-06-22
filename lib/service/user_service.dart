import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:whilabel_renewal/service/base_service.dart';

import '../enums/login_type_enum.dart';


class UserService extends BaseService {

  Future<dynamic> login(LoginType loginType, String snsToken,) async {
    var url =
    Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return  ;
  }

}