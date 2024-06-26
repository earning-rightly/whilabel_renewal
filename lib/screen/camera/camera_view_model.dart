import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/camera/camera_state.dart';

final cameraProvider = StateNotifierProvider<CameraViewModel, CameraState>(
        (ref) => CameraViewModel());


class CameraViewModel extends StateNotifier<CameraState> {

  CameraViewModel() : super(CameraState.initial());



  void updateBarCode(String barcode) {
    state = state.copyWith(barcode: barcode);
  }

  Future<List<CameraDescription>> initCamera() async {
    /// state.cameras를 초기화한다.
    WidgetsFlutterBinding.ensureInitialized();
    final _camera = await availableCameras();

    state = state.copyWith(cameras: _camera);
    return _camera;
  }

}
