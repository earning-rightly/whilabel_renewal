import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/enums/taste_feature_type.dart';
import 'package:whilabel_renewal/service/whisky_service.dart';

import 'create_whisky_post_detail_state.dart';

final _tasteFeatures = [
  TasteFeature(
      title: TasteFeatureType.BODY,
      lowExpression: "가벼움",
      highExpression: "무거움",
      value: 3),
  TasteFeature(
      title: TasteFeatureType.FLAVOR,
      lowExpression: "섬세함",
      highExpression: "스모키함",
      value: 3),
  TasteFeature(
      title: TasteFeatureType.PEAT,
      lowExpression: "언피트",
      highExpression: "피트함",
      value: 3)
];

class CreateWhiskyPostDetailViewModel
    extends StateNotifier<CreateWhiskyPostDetailState> {
  CreateWhiskyPostDetailViewModel()
      : super(CreateWhiskyPostDetailState.initial(
            starScore: 3, note: "", tasteFeatures: _tasteFeatures));

  final provider = StateNotifierProvider<CreateWhiskyPostDetailViewModel,
      CreateWhiskyPostDetailState>((ref) => CreateWhiskyPostDetailViewModel());

  final _whiskyService = WhiskyService();

  void onChangeStarScore(double score) {
    state = state.copyWith(starScore: score);
  }

  Future<void> onChangeTasteFeature(TasteFeatureType feature, int value) async {
    var map = {...state.featureMap};

    map[feature] = value;
    state = state.copyWith(featureMap: map);
  }

  void onChangeNote(String note) {
    state = state.copyWith(note: note);
  }

  void savePost(int whiskyId, String imageUrl) async {
    /* TODO _mockImageUrl제거하기**/
    String _mockImageUrl =
        "https://farm4.staticflickr.com/3075/3168662394_7d7103de7d_z_d.jpg";
    bool isSuccess = false;
    if (imageUrl == "") {
      isSuccess = await _callCreatePostAPI(whiskyId, _mockImageUrl);
      return;
    }
    isSuccess = await _callCreatePostAPI(whiskyId, imageUrl);
    state = state.copyWith(isPostSuccess: isSuccess);
    return;
  }

  Future<bool> _callCreatePostAPI(int whiskyId, String imageUrl) async {
    // ({String name, int age}) minji = (name: '민지', age: 20);
    final CreateWhiskyPostDetailState(
      starScore: rating,
      note: tasteNote,
      featureMap: featureMap
    ) = state;
    final bodyRate = featureMap[TasteFeatureType.BODY]!;
    final flavorRate = featureMap[TasteFeatureType.FLAVOR]!;
    final peatRate = featureMap[TasteFeatureType.PEAT]!;

    final isSuccess = await _whiskyService.postWhiskyDetailPost(
        whiskyId, imageUrl, rating, tasteNote, bodyRate, flavorRate, peatRate);
    return isSuccess;
  }
}
