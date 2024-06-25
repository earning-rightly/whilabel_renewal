import 'package:freezed_annotation/freezed_annotation.dart';


part 'camera_state.freezed.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState({
    // 디테일 페이지에서 보여주고 수정할 post data
    required String barcode
  }) = _CameraState;

  factory CameraState.initial() {
    return CameraState( barcode: "");
  }
}
