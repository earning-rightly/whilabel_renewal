import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:whilabel_renewal/domain/whisky_scan.dart';

import 'scan_main_texts.dart';

part 'scan_main_state.freezed.dart';

@freezed
class ScanMainState with _$ScanMainState {
  const factory ScanMainState({
    // 디테일 페이지에서 보여주고 수정할 post data
    required String albumTitle,
    required bool isFindWhiskyData,
    required List<CameraDescription> cameras,
    required ScanMainTextx texts,
    required WhiskyScan? scanResult,
    required String barcode
  }) = _ScanMainState;

  factory ScanMainState.initial() {
    return ScanMainState( barcode: "", texts: ScanMainTextx(),isFindWhiskyData: false, cameras: [],albumTitle: "", scanResult: null ) ;
  }
}
