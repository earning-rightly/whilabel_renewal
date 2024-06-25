import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';

import './user_critique_container_state.dart';



class UserCritiqueContainerViewModel
    extends StateNotifier<UserCritiqueContainerState> {

  final provider = StateNotifierProvider<
      UserCritiqueContainerViewModel,
      UserCritiqueContainerState>((_) => UserCritiqueContainerViewModel());

  UserCritiqueContainerViewModel()
      : super(UserCritiqueContainerState.initial(
            tasteFeatures: [], starScore: 3, note: ""));

  void setState(
      {required String note,
      required double starScore,
      required List<TasteFeature> features}) {
    Map<String, int> tasteFeatureMap = {};

    features.forEach((feature) {
      tasteFeatureMap[feature.title] = feature.value;
    });

    state = state.copyWith(
      featureMap: tasteFeatureMap,
      tasteFeatures: features,
      note: note,
      starScore: starScore,
    );
  }

  void onChangeStarScore(double score) {
    state = state.copyWith(starScore: score);
    print(score);
  }

  Future<void> onChangeTasteFeature(String featureName, int value) async {
    var map = {...state.featureMap};

    map[featureName] = value;
    state = state.copyWith(featureMap: map);
  }

  Future<double> getStarScore() async {
    return state.starScore;
  }

  Future<List<TasteFeature>> getFeatures() async {
    final features = state.tasteFeatures;
    final Map<String, int> featureMap = state.featureMap;

    final List<TasteFeature> updatedFeatures = [];

    for (var feature in features) {
      final newFeature = feature.copyWith(
          value: featureMap[feature.title] ??
              feature.value // 저장하는데 이상이 있으면 원래 값으로 저장
          );
      updatedFeatures.add(newFeature);
    }

    return updatedFeatures;
  }
}
