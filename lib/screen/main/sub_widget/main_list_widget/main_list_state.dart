import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/domain/whiskypost_response.dart';

part 'main_list_state.freezed.dart';

@freezed
class MainListState with _$MainListState {
  const factory MainListState({
    required List<WhiskyPostResponse> data,
    required String currentSortType,
  }) = _MainListState;

  factory MainListState.initial() {
    return MainListState(data: [],currentSortType: "recent");
  }
}
