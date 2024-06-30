import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/domain/whiskypost_response.dart';
import 'base_response.dart';

part 'whiskypost_list_response.g.dart';


@JsonSerializable()
class WhiskyPostListResponse extends BaseResponses<List<WhiskyPostResponse>>  {


  WhiskyPostListResponse({
    required super.message,
    required super.data,
    required super.code,
  });


  factory WhiskyPostListResponse.fromJson(Map<String, dynamic> json)
  => _$WhiskyPostListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WhiskyPostListResponseToJson(this);
}
