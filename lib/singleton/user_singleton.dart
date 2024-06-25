
import 'package:whilabel_renewal/domain/userme_response.dart';

class UserSingleton {
  static final UserSingleton instance =
  UserSingleton._internal();
  factory UserSingleton() => instance;
  UserSingleton._internal();

  UsermeResponse? _data;

  void setUserMeResponse(UsermeResponse? data) {
    _data = data;
  }

  UsermeResponse? getUserMeResponse() {
    return _data;
  }
}