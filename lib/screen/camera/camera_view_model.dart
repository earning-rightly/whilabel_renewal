import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/camera/camera_state.dart';
import 'package:whilabel_renewal/screen/camera/photo_taking/photo_taking_view.dart';
import 'package:whilabel_renewal/screen/util_views/show_dialog.dart';
import 'package:whilabel_renewal/service/whisky_service.dart';

final cameraProvider = StateNotifierProvider<CameraViewModel, CameraState>(
    (ref) => CameraViewModel());

class CameraViewModel extends StateNotifier<CameraState> {
  CameraViewModel() : super(CameraState.initial());

  final _whiskyService = WhiskyService();

  Future<bool> updateBarCode(String barcode) async {


    return await _callGetWhiskyByBarcodeAPI(barcode);
  }

  Future<bool> _callGetWhiskyByBarcodeAPI(String barcode) async {
    print("_callGetWhiskyByBarcodeAPI () barcode ===>>>$barcode");
    final (isSuccess, scanResult) =
        await _whiskyService.getWhiskyByBarcode(barcode);
    if (isSuccess) {
      state = state.copyWith(scanResult: scanResult.data, barcode: barcode);
      debugPrint("getWhiskyByBarcode 성공");
      if(scanResult.data?.whiskyId== null){

        state=state.copyWith(isFindWhiskyData: false);
        return false;
      }

    } else {
      debugPrint("getWhiskyByBarcode API 결과는 실패 ");
    }
    return isSuccess;
  }

  Future<void> showBarcodeNoMatchDialog(
      BuildContext context, List<CameraDescription> cameras) async {
    showSimpleDialog(context, "인식되지 않은 위스키", "위라벨 팀이 검토 후 나머지 정보를\n빠르게 채워드릴게요!",
        onClickOktButton: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return PhotoTakingView(
          cameras: cameras,
        );
      }));
    });
  }
}
