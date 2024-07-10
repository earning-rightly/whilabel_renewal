import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/camera/camera_state.dart';
import 'package:whilabel_renewal/screen/camera/custom_barcode_scanner/custom_barcode_scanner_view.dart';
import 'package:whilabel_renewal/screen/camera/photo_taking/photo_taking_view.dart';
import 'package:whilabel_renewal/service/whisky_service.dart';

import 'barcode_scan/barcode_scan_view.dart';

final cameraProvider = StateNotifierProvider<CameraViewModel, CameraState>(
    (ref) => CameraViewModel());

class CameraViewModel extends StateNotifier<CameraState> {
  CameraViewModel() : super(CameraState.initial());

  final _whiskyService = WhiskyService();

  BuildContext? _context;



  void setBuildContext(BuildContext context) {
    _context = context;
  }

  void showBarcodeScanView() async {
    String barcode = "";
    barcode = await Navigator.push(
        _context!,
        MaterialPageRoute(
          builder: (context) => const CustomBarcodeScannerView(),
        ));

    _callGetWhiskyByBarcodeAPI(barcode);
  }

  void _callGetWhiskyByBarcodeAPI(String barcode) async {
    print("_callGetWhiskyByBarcodeAPI () barcode ===>>>$barcode");
    final (isSuccess, scanResult) =
        await _whiskyService.getWhiskyByBarcode(barcode);
    if (isSuccess) {
      state = state.copyWith(scanResult: scanResult.data, barcode: barcode);
      debugPrint("getWhiskyByBarcode 성공");
    } else {
      debugPrint("getWhiskyByBarcode API 결과는 실패 ");
    }

    _showPhotoTakingView();
  }

  void _showPhotoTakingView() async {
    final cameras = await getCamera();
    Navigator.push(
      _context!,
      MaterialPageRoute(
        builder: (context) =>
            PhotoTakingView(cameras: cameras),
      ),
    );
  }

  Future<List<CameraDescription>> getCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final _camera = await availableCameras();

    return _camera;
  }

}
