import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';
import './archiving_post_detail_state.dart';
import 'archiving_post_view_text.dart';


class ArchivingPostDetailViewModel
    extends StateNotifier<ArchivingPostDetailState> {

  final provider = StateNotifierProvider<ArchivingPostDetailViewModel,ArchivingPostDetailState>( (ref) {
    return ArchivingPostDetailViewModel();
  });

  static ArchivingPostViewText mockTexts = ArchivingPostViewText(
      strength: '10',
      createAt: "1100",
      distillery: " mock distillery",
      whiskeyName: "whiskeyName");

  ArchivingPostDetailViewModel()
      : super(ArchivingPostDetailState.initial(
      postId: 0, mockTexts, tasteFeatures: [], starScore: 3, note: ""));

  void setState({required int postId,
    required bool isModify,
    required String note,
    required double starScore,
    required List<TasteFeature> features}) {
    this.state = this.state.copyWith(
      postId: postId,
      isModify: isModify,
      tasteFeatures: features,
      note: note,
      starScore: starScore,
    );
  }

  void setIsModifyState(bool state) {
    this.state = this.state.copyWith(isModify: !state);
  }

  Future<void> updatePostInfo(double starScore, String note,
      List<TasteFeature> features, WidgetRef ref) async {
    final homeViewModel = ref.read(mockHomeViewModelProvider.notifier);

    // detaill view state update
    this.state = this.state.copyWith(
      tasteFeatures: features,
      note: note,
      starScore: starScore,
    );
    // home view stare update
    await homeViewModel.updateArchivingPost(
        state.postId, starScore, note, features);

    // TODO DB에 post 정보 변경 로직 추가하기
  }


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
