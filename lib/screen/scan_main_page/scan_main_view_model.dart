import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/scan_main_page/photo_taking/photo_taking_view.dart';
import 'package:whilabel_renewal/screen/scan_main_page/scan_main_state.dart';
import 'package:whilabel_renewal/service/whisky_service.dart';

import 'custom_barcode_scanner/custom_barcode_scanner_view.dart';




class ScanMainViewModel extends StateNotifier<ScanMainState> {
  ScanMainViewModel() : super(ScanMainState.initial());

  final _whiskyService = WhiskyService();

  BuildContext? _context;

  final provider = StateNotifierProvider<ScanMainViewModel, ScanMainState>(
          (ref) => ScanMainViewModel());



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
    final (_, scanResult) =
        await _whiskyService.getWhiskyByBarcode(barcode);
    if (scanResult.data != null) {
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
