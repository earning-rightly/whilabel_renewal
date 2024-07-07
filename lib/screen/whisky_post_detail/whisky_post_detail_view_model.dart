import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whilabel_renewal/data/taste/taste_feature.dart';
import 'package:whilabel_renewal/domain/tastefeature_response.dart';
import 'package:whilabel_renewal/enums/taste_feature_type.dart';
import 'package:whilabel_renewal/screen/whisky_post_detail/sub_widget/user_critique_container/user_critique_container_view_model.dart';
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
        title: TasteFeatureType.BODY,
        lowExpression: "가벼움",
        highExpression: "무거움",
        value: data.bodyRate.toInt()));

    tasteFeatures.add(TasteFeature(
        title: TasteFeatureType.BODY,
        lowExpression: "섬세함",
        highExpression: "스모키함",
        value: data.flavorRate.toInt()));

    tasteFeatures.add(TasteFeature(
        title:TasteFeatureType.BODY,
        lowExpression: "언피트",
        highExpression: "피트함",
        value: data.peatRate.toInt()));
    return tasteFeatures;
  }

  void setIsModifyState(bool state) {
    this.state = this.state.copyWith(isModify: state);
  }

  void processWhiskyPostUpdate(UserCritiqueContainerViewModel userCritiqueViewModel,String tasteNote) async {
    final score = await userCritiqueViewModel.getStarScore();
    final features = await userCritiqueViewModel.getFeatures();
     this._callUpdateWhiskyPostAPI(score, tasteNote, features);
  }

  void _callUpdateWhiskyPostAPI(double starScore, String note,
      List<TasteFeature> features) async {
    final bodyRate = features.where( (item) => item.title == "바디감").first.value;
    final flavorRate = features.where( (item) => item.title == "향").first.value;
    final peatRate = features.where( (item) => item.title == "피트감").first.value;

    final result = await _whiskyService.putPostDetail(state.data?.id ?? 0,
        starScore,
        note,
        bodyRate.toDouble(),
        flavorRate.toDouble(),
        peatRate.toDouble());

    if (result) {
      init(state.data?.id ?? 0);
    }
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
