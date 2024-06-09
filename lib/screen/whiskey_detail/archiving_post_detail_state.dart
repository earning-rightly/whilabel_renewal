import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';

import './archiving_post_view_text.dart';

part 'archiving_post_detail_state.freezed.dart';

@freezed
class ArchivingPostDetailState with _$ArchivingPostDetailState {
  const factory ArchivingPostDetailState(
      {required int postId,
      required ArchivingPostViewText texts,
      required bool isModify,
      required String note,
      required double starScore,
      required List<TasteFeature> tasteFeatures}) = _ArchivingPostDetailState;

  factory ArchivingPostDetailState.initial(ArchivingPostViewText texts,
      {required int postId,
      required String note,
      required double starScore,
      required List<TasteFeature> tasteFeatures}) {
    return ArchivingPostDetailState(
        postId: postId,
        texts: texts,
        isModify: false,
        note: note,
        starScore: starScore,
        tasteFeatures: tasteFeatures);
  }
}
