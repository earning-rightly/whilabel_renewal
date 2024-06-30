import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/domain/whisky_post_detail_model.dart';
import 'package:whilabel_renewal/domain/whiskypostdetail_response.dart';
import './whisky_post_view_text.dart';

part 'whisky_post_detail_state.freezed.dart';

@freezed
class WhiskyPostDetailState with _$WhiskyPostDetailState {
  const factory WhiskyPostDetailState(
      {required WhiskyPostViewText texts,
      required bool isModify,
      required List<TasteFeature> tasteFeatures,
      required WhiskyPostDetailModel? data}) = _WhiskyPostDetailState;

  factory WhiskyPostDetailState.initial() {
    return WhiskyPostDetailState(
        texts: WhiskyPostViewText(), isModify: false, tasteFeatures: [], data: null);
  }
}
