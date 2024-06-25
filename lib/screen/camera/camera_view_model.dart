import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/camera/camera_state.dart';


class CameraViewModel extends StateNotifier<CameraState> {
  final provider = StateNotifierProvider<CameraViewModel, CameraState>(
          (ref) => CameraViewModel());

  CameraViewModel() : super(CameraState.initial());

  void updateBarCode(String barcode) {
    state = state.copyWith(barcode: barcode);
  }

  Future<void> initCamera() async {
    /// state.cameras를 초기화한다.
    WidgetsFlutterBinding.ensureInitialized();
    final _camera = await availableCameras();

    state = state.copyWith(cameras: _camera);
    // notifyListeners();
  }


}
