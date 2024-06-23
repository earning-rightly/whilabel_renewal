import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/domain/tastefeature_response.dart';
import 'base_response.dart';

part 'whiskypostdetail_response.g.dart';


@JsonSerializable()
class WhiskyPostDetailResponse  {

  final int id;
  final int userId;
  final String distilleryImage;
  final String whiskyImage;
  final String whiskyName;
  final String distilleryAddress;
  final String distilleryCountry;
  final double distillerRating;
  final String createdDateTime;
  final String? modifyDateTime;
  final double starRating;
  final String tasteNote;
  final TasteFeatureResponse tasteFeature;

  WhiskyPostDetailResponse({
    required this.id,
    required this.userId,
    required this.distilleryImage,
    required this.whiskyImage,
    required this.whiskyName,
    required this.distilleryAddress,
    required this.distilleryCountry,
    required this.distillerRating,
    required this.createdDateTime,
    required this.modifyDateTime,
    required this.starRating,
    required this.tasteNote,
    required this.tasteFeature,
  });


  factory WhiskyPostDetailResponse.fromJson(Map<String, dynamic> json)
  => _$WhiskyPostDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WhiskyPostDetailResponseToJson(this);
}
