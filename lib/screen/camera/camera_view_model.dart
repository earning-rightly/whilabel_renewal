import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/camera/camera_state.dart';


class CameraViewModel extends StateNotifier<CameraState> {
  final provider = StateNotifierProvider<CameraViewModel, CameraState>(
          (ref) => CameraViewModel());

  CameraViewModel() : super(CameraState.initial());

  void updateBarCode(String barcode) {
    state = state.copyWith(barcode: barcode);
  }


}
