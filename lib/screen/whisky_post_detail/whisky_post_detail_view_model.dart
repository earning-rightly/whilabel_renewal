import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/domain/tastefeature_response.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';
import 'package:whilabel_renewal/service/whisky_service.dart';
import './whisky_post_detail_state.dart';
import 'whisky_post_view_text.dart';

class WhiskyPostDetailViewModel extends StateNotifier<WhiskyPostDetailState> {

  final _whiskyService = WhiskyService();
  BuildContext? _context;

  final provider =
      StateNotifierProvider<WhiskyPostDetailViewModel, WhiskyPostDetailState>(
          (_) {
    return WhiskyPostDetailViewModel();
  });


  WhiskyPostDetailViewModel() : super(WhiskyPostDetailState.initial());

  void setBuildContext(BuildContext context) {
    _context = context;
  }

  void init(int postId) async {
    final (isSuccess, result) = await _whiskyService.getPostDetail(postId);
    final data = result.data;
    if (isSuccess && data != null) {
      List<TasteFeature> tasteFeatures = _makeTasteFeature(data.tasteFeature);
      state = state.copyWith(data: data,tasteFeatures: tasteFeatures);
    }
    else {

    }
  }

  List<TasteFeature> _makeTasteFeature(TasteFeatureResponse data) {
    List<TasteFeature> tasteFeatures = [];
    tasteFeatures.add(TasteFeature(
        title: "바디감",
        lowExpression: "가벼움",
        highExpression: "무거움",
        value: data.bodyRate.toInt()));

    tasteFeatures.add(TasteFeature(
        title: "향",
        lowExpression: "섬세함",
        highExpression: "스모키함",
        value: data.flavorRate.toInt()));

    tasteFeatures.add(TasteFeature(
        title: "피트감",
        lowExpression: "언피트",
        highExpression: "피트함",
        value: data.peatRate.toInt()));
    return tasteFeatures;
  }


  // Future<void> setState(
  //     {required int postId,
  //     required bool isModify,
  //     required String note,
  //     required double starScore,
  //     required List<TasteFeature> features}) async {
  //   this.state = this.state.copyWith(
  //         postId: postId,
  //         isModify: isModify,
  //         tasteFeatures: features,
  //         note: note,
  //         starScore: starScore,
  //       );
  // }

  void setIsModifyState(bool state) {
    this.state = this.state.copyWith(isModify: state);
  }

  // Future<void> updatePostInfo(double starScore, String note,
  //     List<TasteFeature> features, WidgetRef ref) async {
  //   final homeProvider = MockHomeViewModel().provider;
  //   final homeViewModel = ref.watch(homeProvider.notifier);
  //
  //   // detaill view state update
  //   this.state = this.state.copyWith(
  //         tasteFeatures: features,
  //         note: note,
  //         starScore: starScore,
  //       );
  //   // home view stare update
  //   await homeViewModel.updateArchivingPost(
  //       state.postId, starScore, note, features);
  //
  //   // TODO DB에 post 정보 변경 로직 추가하기
  // }

  Future<void> modifyNote(String note) async {
    //TODO  note 값 변경
  }

  Future<void> modifyStarScore(int score) async {
    //TODO  stareScore 변경
  }

  Future<void> modifyStarTasteFeature(TasteFeature tasteFeature) async {
    // TODO List<TasteFeature>tasteFeatures 변경
  }

  String getDistilleryAddressAndCountry() {
    return (state.data?.distilleryCountry ?? "") +
        (state.data?.distilleryAddress ?? "");
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy.MM.dd').format(dateTime);
  }

  String getWhiskyName() {
    final data = state.data;
    if (data != null) {
      return data.whiskyName;
    }
    else {
      return "위스키를 등록 중입니다.";
    }
  }
}
