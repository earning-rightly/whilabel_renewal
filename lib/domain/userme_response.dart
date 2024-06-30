import 'package:freezed_annotation/freezed_annotation.dart';
import 'base_response.dart';

part 'userme_response.g.dart';

@JsonSerializable()
class UsermeResponse extends BaseResponses<UsermeResponse> {
  final int id;
  final String snsLoginType;
  final String nickname;
  final bool isPushAllowed;
  final bool isMarketingAllowed;
  final String pushToken;
  final bool isResigned;
  final String gender;
  final String birthDay;
  final int whiskyCount;

  UsermeResponse({
    required super.message,
    required super.data,
    required super.code,
    required this.id,
    required this.snsLoginType,
    required this.nickname,
    required this.isPushAllowed,
    required this.isMarketingAllowed,
    required this.pushToken,
    required this.isResigned,
    required this.gender,
    required this.birthDay,
    required this.whiskyCount,
  });

  factory UsermeResponse.fromJson(Map<String, dynamic> json) =>
      _$UsermeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UsermeResponseToJson(this);
}
