import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/screen/mock_data/taste/taste_feature.dart';

import 'archiving_post_view_text.dart';

part 'archiving_post_detail_state.freezed.dart';

@freezed
class ArchivingPostDetailState with _$ArchivingPostDetailState {
  const factory ArchivingPostDetailState({
    required ArchivingPostViewText settingViewText,
    required String note,
    required int starScore,
    required List<TasteFeature> tasteFeatures

  }) = _ArchivingPostDetailState;

  factory ArchivingPostDetailState.initial(){
    return ArchivingPostDetailState(
        settingViewText: ArchivingPostViewText(),
      note: "",
        starScore: 0,
      tasteFeatures: []
       );
  }
}



