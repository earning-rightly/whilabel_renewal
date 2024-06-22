
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

import 'base_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseResponses<LoginResponse> {
  // final String? message;
  final String? token;

  LoginResponse({
    required this.token, required super.message, required super.data
});

  factory LoginResponse.fromJson(Map<String, dynamic> json)
  => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

