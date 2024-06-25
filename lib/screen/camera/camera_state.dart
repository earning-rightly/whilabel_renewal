import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'camera_view_texts.dart';

part 'camera_state.freezed.dart';

@freezed
class CameraState with _$CameraState {
  const factory CameraState({
    // 디테일 페이지에서 보여주고 수정할 post data
    required String albumTitle,
    required bool isFindWhiskyData,
    required List<CameraDescription> cameras,
    required CameraViewTexts texts,

    required String barcode
  }) = _CameraState;

  factory CameraState.initial() {
    return CameraState( barcode: "", texts: CameraViewTexts(),isFindWhiskyData: false, cameras: [],albumTitle: "" ) ;
  }
}
