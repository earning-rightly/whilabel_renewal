import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:whilabel_renewal/screen/custom_barcode_scanner/custom_barcode_scanner_view_model.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class CustomBarcodeScannerView extends ConsumerStatefulWidget {
  const CustomBarcodeScannerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
   return _CustomBarcodeScannerViewState();
  }

}

class _CustomBarcodeScannerViewState extends ConsumerState<CustomBarcodeScannerView> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isDetecting = false;
  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: Text('Barcode Scanner')),
      body: CameraPreview(_controller!),
    );
  }

}
extension _CameraFunctions on _CustomBarcodeScannerViewState {

  void initializeCamera() async {

    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.high);
    await _controller!.initialize();

    if (!mounted) return;
    setState(() {
      print("set state");
    });

    _controller!.startImageStream((CameraImage image) {
      if (!_isDetecting) {
        _isDetecting = true;
        _processCameraImage(image);
      }
    });
  }

  Future<void> _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (var plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

    final InputImageRotation imageRotation =
        InputImageRotationMethods.fromRawValue(_cameras[0].sensorOrientation) ?? InputImageRotation.Rotation_0deg;

    final InputImageFormat inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ?? InputImageFormat.NV21;

    final planeData = image.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    final barcodes = await barcodeScanner.processImage(inputImage);

    if (barcodes.isNotEmpty) {
      for (Barcode barcode in barcodes) {
        final String displayValue = barcode.value.displayValue!;
        print('Barcode found! Value: $displayValue');
        // 바코드 값 사용하여 추가 작업 수행
        _controller?.pausePreview();
      }
    }

    _isDetecting = false;
  }

}

