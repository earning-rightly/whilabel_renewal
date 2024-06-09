import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';

part 'user_crique_container_state.freezed.dart';

@freezed
class UserCriqueContainerState with _$UserCriqueContainerState {
  const factory UserCriqueContainerState({
    required String note,
    required double starScore,
    required List<TasteFeature> tasteFeatures,
    required Map<String, int> featureMap,
  }) = _UserCriqueContainerState;

  factory UserCriqueContainerState.initial(
      {required String note,
      required double starScore,
      required List<TasteFeature> tasteFeatures}) {
    return UserCriqueContainerState(
      note: note,
      starScore: starScore,
      tasteFeatures: tasteFeatures,
      featureMap: {},
    );
  }
}
