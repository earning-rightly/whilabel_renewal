import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/domain/tastefeature_response.dart';
import 'package:whilabel_renewal/domain/whisky_post_detail_model.dart';
import 'base_response.dart';

part 'whiskypostdetail_response.g.dart';


@JsonSerializable()
class WhiskyPostDetailResponse extends BaseResponses<WhiskyPostDetailModel>  {


  WhiskyPostDetailResponse({
    required super.message,
    required super.data,
    required super.code,
  });


  factory WhiskyPostDetailResponse.fromJson(Map<String, dynamic> json)
  => _$WhiskyPostDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WhiskyPostDetailResponseToJson(this);
}
