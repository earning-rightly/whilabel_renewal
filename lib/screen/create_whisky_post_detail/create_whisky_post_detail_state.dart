import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/enums/taste_feature_type.dart';

part 'create_whisky_post_detail_state.freezed.dart';

@freezed
class CreateWhiskyPostDetailState with _$CreateWhiskyPostDetailState {
  const factory CreateWhiskyPostDetailState({
    required bool isPostSuccess,
    required String note,
    required double starScore,
    required List<TasteFeature> tasteFeatures,
    required Map<TasteFeatureType, int> featureMap,
  }) = _CreateWhiskyPostDetailState;

  factory CreateWhiskyPostDetailState.initial(
      {
        required String note,
        required double starScore,
        required List<TasteFeature> tasteFeatures}) {
    // Map<String, int> featureMap;
    // Map<String, int> featureMap = tasteFeatures.map((value)=> value);

    // Map<String, int> tasteFeatureMap = tasteFeatures.map((feature) => MapEntry(feature.title, feature.value)) as Map<String, int>;
    Map<TasteFeatureType, int> tasteFeatureMap = tasteFeatures.asMap().map((key, value) => MapEntry(value.title, value.value));

    return CreateWhiskyPostDetailState(
      isPostSuccess: false,
      note: note,
      starScore: starScore,
      tasteFeatures: tasteFeatures,
      featureMap: tasteFeatureMap,
    );
  }
}
