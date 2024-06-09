import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:json_annotation/json_annotation.dart';

part 'taste_feature.g.dart';
part 'taste_feature.freezed.dart';

@freezed
class TasteFeature with _$TasteFeature {
  factory TasteFeature(
      {
        required String title,
        required String lowExpression,
        required String highExpression,
        required int value
      }) = _TasteFeature;

  factory TasteFeature.fromJson(Map<String, dynamic> json) =>
      _$TasteFeatureFromJson(json);
}