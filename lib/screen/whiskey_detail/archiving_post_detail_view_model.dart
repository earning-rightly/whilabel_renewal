import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/mock_data/taste/taste_feature.dart';

import './archiving_post_detail_state.dart';


final settingViewProvider =
StateNotifierProvider<ArchivingPostDetailViewModel, ArchivingPostDetailState>(
        (ref) => ArchivingPostDetailViewModel(ref));

class ArchivingPostDetailViewModel extends StateNotifier<ArchivingPostDetailState> {
  final Ref ref;

  ArchivingPostDetailViewModel(this.ref) : super(ArchivingPostDetailState.initial());

  Future<void> modifyNote(String note) async {
    //TODO  note 값 변경

  }

  Future<void> modifyStarScore(int score) async {
    //TODO  stareScore 변경

  }

  Future<void> modifyStarTasteFeature(TasteFeature tasteFeature) async {
  // TODO List<TasteFeature>tasteFeatures 변경
  }


}
