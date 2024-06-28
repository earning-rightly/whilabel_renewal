import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/camera/camera_state.dart';
import 'package:whilabel_renewal/service/whisky_service.dart';

final cameraProvider = StateNotifierProvider<CameraViewModel, CameraState>(
        (ref) => CameraViewModel());


class CameraViewModel extends StateNotifier<CameraState> {

  CameraViewModel() : super(CameraState.initial());

  final _whiskyService= WhiskyService();


  Future <void> updateBarCode(String barcode) async{
   await  _callGetWhiskyByBarcodeAPI(barcode);
  }

  Future<void> _callGetWhiskyByBarcodeAPI( String barcode) async{

print("_callGetWhiskyByBarcodeAPI () barcode ===>>>$barcode");
   final  (isSuccess ,scanResult)  = await  _whiskyService.getWhiskyByBarcode(barcode);
   if (isSuccess){
     state =state.copyWith(scanResult: scanResult.data, barcode: barcode);
     debugPrint("getWhiskyByBarcode 성공");
   }else{
     debugPrint("getWhiskyByBarcode API 결과는 실패 ");
   }
  }

}
