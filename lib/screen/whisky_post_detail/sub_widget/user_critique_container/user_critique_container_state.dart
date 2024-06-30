import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';

part 'user_critique_container_state.freezed.dart';

@freezed
class UserCritiqueContainerState with _$UserCritiqueContainerState {
  const factory UserCritiqueContainerState({
    required String note,
    required double starScore,
    required List<TasteFeature> tasteFeatures,
    required Map<String, int> featureMap,
  }) = _UserCritiqueContainerState;

  factory UserCritiqueContainerState.initial(
      {required String note,
      required double starScore,
      required List<TasteFeature> tasteFeatures}) {
    return UserCritiqueContainerState(
      note: note,
      starScore: starScore,
      tasteFeatures: tasteFeatures,
      featureMap: {},
    );
  }
}
