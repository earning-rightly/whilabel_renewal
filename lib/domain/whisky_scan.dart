import 'package:freezed_annotation/freezed_annotation.dart';

part 'whisky_scan.g.dart';

@JsonSerializable()
class WhiskyScan {
  final int? whiskyId;
  final String? whiskyName;
  final String? distilleryAddress;
  final String? distilleryCountry;
  final double? distilleryRating;

  WhiskyScan({
    required this.whiskyId,
    required this.whiskyName,
    required this.distilleryRating,
    required this.distilleryAddress,
    required this.distilleryCountry,
  });

  factory WhiskyScan.fromJson(Map<String, dynamic> json) =>
      _$WhiskyScanFromJson(json);

  Map<String, dynamic> toJson() => _$WhiskyScanToJson(this);
}
