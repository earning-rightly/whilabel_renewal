import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/enums/taste_feature_type.dart';
import 'package:whilabel_renewal/service/whisky_service.dart';

import 'create_archiving_post_state.dart';

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

class CreateArchivingPostViewModel
    extends StateNotifier<CreateArchivingPostState> {
  CreateArchivingPostViewModel()
      : super(CreateArchivingPostState.initial(
            starScore: 3, note: "", tasteFeatures: _tasteFeatures));

  final provider = StateNotifierProvider<CreateArchivingPostViewModel,
      CreateArchivingPostState>((ref) => CreateArchivingPostViewModel());

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
    bool isResult = false;
    if (imageUrl == "") {
      isResult = await _callCreatePostAPI(whiskyId, _mockImageUrl);
      return;
    }
    isResult = await _callCreatePostAPI(whiskyId, imageUrl);
    state = state.copyWith(isPostResult: isResult);
    return;
  }

  Future<bool> _callCreatePostAPI(int whiskyId, String imageUrl) async {
    // ({String name, int age}) minji = (name: '민지', age: 20);
    final CreateArchivingPostState(
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
