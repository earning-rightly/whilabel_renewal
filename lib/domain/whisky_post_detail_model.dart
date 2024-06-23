


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/domain/tastefeature_response.dart';
import 'base_response.dart';

part 'whisky_post_detail_model.g.dart';


@JsonSerializable()
class WhiskyPostDetailModel  {

  final int id;
  final int userId;
  final String distilleryImage;
  final String whiskyImage;
  final String whiskyName;
  final String distilleryAddress;
  final String distilleryCountry;
  final double distilleryRating;
  final String createDateTime;
  final String? modifyDateTime;
  final double starRating;
  final String tasteNote;
  final TasteFeatureResponse tasteFeature;

  WhiskyPostDetailModel({
    required this.id,
    required this.userId,
    required this.distilleryImage,
    required this.whiskyImage,
    required this.whiskyName,
    required this.distilleryAddress,
    required this.distilleryCountry,
    required this.distilleryRating,
    required this.createDateTime,
    required this.modifyDateTime,
    required this.starRating,
    required this.tasteNote,
    required this.tasteFeature,
  });


  factory WhiskyPostDetailModel.fromJson(Map<String, dynamic> json)
  => _$WhiskyPostDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$WhiskyPostDetailModelToJson(this);
}
