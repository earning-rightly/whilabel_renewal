

import 'package:whilabel_renewal/enums/login_type_enum.dart';

class RegisterSingleton {
  static final RegisterSingleton instance =
  RegisterSingleton._internal();
  factory RegisterSingleton() => instance;
  RegisterSingleton._internal();

  LoginType loginType = LoginType.kakaotalk;
  String snsToken = "";
  String nickname = "";

}