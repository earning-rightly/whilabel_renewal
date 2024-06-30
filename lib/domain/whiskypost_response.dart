import 'package:freezed_annotation/freezed_annotation.dart';
import 'base_response.dart';

part 'whiskypost_response.g.dart';


@JsonSerializable()
class WhiskyPostResponse  {

  final int id;
  final int whiskyId;
  final String name;
  final String address;
  final String tasteNote;
  final String createDateTime;
  final String? modifyDateTime;
  final double rating;
  final double distilleryRating;
  final String imageUrl;

  WhiskyPostResponse({
    required this.id,
    required this.whiskyId,
    required this.name,
    required this.address,
    required this.tasteNote,
    required this.createDateTime,
    required this.modifyDateTime,
    required this.rating,
    required this.distilleryRating,
    required this.imageUrl,
  });


  factory WhiskyPostResponse.fromJson(Map<String, dynamic> json)
  => _$WhiskyPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WhiskyPostResponseToJson(this);
}
