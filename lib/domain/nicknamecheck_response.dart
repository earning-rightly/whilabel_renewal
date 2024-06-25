import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

import 'base_response.dart';

part 'nicknamecheck_response.g.dart';

@JsonSerializable()
class NicknameCheckResponse extends BaseResponses<NicknameCheckResponse>  {

  NicknameCheckResponse() : super(message: null, data: null);

  factory NicknameCheckResponse.fromJson(Map<String, dynamic> json)
  => _$NicknameCheckResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NicknameCheckResponseToJson(this);
}
