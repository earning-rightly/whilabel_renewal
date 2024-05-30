import 'package:freezed_annotation/freezed_annotation.dart';
part 'resign_view_state.freezed.dart';

@freezed
class ResignViewState with _$ResignViewState {
  const factory ResignViewState({
    required String mainCautionText,
    required String cautionContentTextOne,
    required String cautionContentTextTwo,
    required String cautionContentTextThree,
  }) = _ResignViewState;

  factory ResignViewState.initial() {
    return ResignViewState(
      mainCautionText: "지금 탈퇴하면 위라벨에서 제공하는 다양한 혜택을 더이상 누릴 수 없어요",
      cautionContentTextOne: "위스키 맛과 브랜드의 특징에 접근할 수 없습니다.",
      cautionContentTextTwo: "수동으로 등록된 위스키에 대한 정보는 보관됩니다.",
      cautionContentTextThree: "나의 위스키 기록(사진, 별점, 한중평 등)이 영구적으로 삭제됩니다",
    );
  }
}
