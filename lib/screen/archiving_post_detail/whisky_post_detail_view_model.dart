import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';
import './whisky_post_detail_state.dart';
import 'whisky_post_view_text.dart';

class WhiskyPostDetailViewModel
    extends StateNotifier<WhiskyPostDetailState> {
  final provider = StateNotifierProvider<WhiskyPostDetailViewModel,
      WhiskyPostDetailState>((ref) {
    return WhiskyPostDetailViewModel();
  });

  static WhiskyPostViewText mockTexts = WhiskyPostViewText(
      strength: '10',
      createAt: "2024.06.09",
      distillery: " mock distillery",
      whiskeyName: "whiskeyName");

  WhiskyPostDetailViewModel()
      : super(WhiskyPostDetailState.initial(
            postId: 0, mockTexts, tasteFeatures: [], starScore: 3, note: ""));

  Future<void> setState(
      {required int postId,
      required bool isModify,
      required String note,
      required double starScore,
      required List<TasteFeature> features}) async {
    this.state = this.state.copyWith(
          postId: postId,
          isModify: isModify,
          tasteFeatures: features,
          note: note,
          starScore: starScore,
        );
  }

  void setIsModifyState(bool state) {
    this.state = this.state.copyWith(isModify: state);
  }

  Future<void> updatePostInfo(double starScore, String note,
      List<TasteFeature> features, WidgetRef ref) async {
    final homeProvider = MockHomeViewModel().provider;
    final homeViewModel = ref.watch(homeProvider.notifier);

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
