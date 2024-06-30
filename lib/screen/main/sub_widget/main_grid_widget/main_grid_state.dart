import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/domain/whiskypost_response.dart';

part 'main_grid_state.freezed.dart';

@freezed
class MainGridState with _$MainGridState {
  const factory MainGridState({
    required List<WhiskyPostResponse> data
  }) = _MainGridState;

  factory MainGridState.initial() {
    return MainGridState(data: []);
  }
}
