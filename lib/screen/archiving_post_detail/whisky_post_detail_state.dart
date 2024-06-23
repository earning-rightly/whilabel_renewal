import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import './whisky_post_view_text.dart';


part 'whisky_post_detail_state.freezed.dart';

@freezed
class WhiskyPostDetailState with _$WhiskyPostDetailState {
  const factory WhiskyPostDetailState(
      {required int postId,
      required WhiskyPostViewText texts,
      required bool isModify,
      required String note,
      required double starScore,
      required List<TasteFeature> tasteFeatures}) = _WhiskyPostDetailState;

  factory WhiskyPostDetailState.initial(WhiskyPostViewText texts,
      {required int postId,
      required String note,
      required double starScore,
      required List<TasteFeature> tasteFeatures}) {
    return WhiskyPostDetailState(
        postId: postId,
        texts: texts,
        isModify: false,
        note: note,
        starScore: starScore,
        tasteFeatures: tasteFeatures);
  }
}
