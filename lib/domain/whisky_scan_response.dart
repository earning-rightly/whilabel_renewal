import 'package:freezed_annotation/freezed_annotation.dart';
import 'base_response.dart';
import 'whisky_scan.dart';

part 'whisky_scan_response.g.dart';

@JsonSerializable()
class WhiskyScanResponse extends BaseResponses<WhiskyScan> {
  WhiskyScanResponse({
    required super.message,
    required super.data,
    required super.code
  });

  factory WhiskyScanResponse.fromJson(Map<String, dynamic> json) =>
      _$WhiskyScanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WhiskyScanResponseToJson(this);
}
