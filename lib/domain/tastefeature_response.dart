import 'package:freezed_annotation/freezed_annotation.dart';
part 'tastefeature_response.g.dart';

@JsonSerializable()
class TasteFeatureResponse  {

  final int id;
  final double bodyRate;
  final double flavorRate;
  final double peatRate;

  TasteFeatureResponse({
    required this.id,
    required this.bodyRate,
    required this.flavorRate,
    required this.peatRate,
  });


  factory TasteFeatureResponse.fromJson(Map<String, dynamic> json)
  => _$TasteFeatureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TasteFeatureResponseToJson(this);
}
