
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:whilabel_renewal/screen/camera/camera_view_model.dart';
import 'package:whilabel_renewal/screen/camera/custom_barcode_scanner/sub_widget/barcode_detector_painter.dart';
import 'package:whilabel_renewal/screen/camera/custom_barcode_scanner/sub_widget/detector_view.dart';

class CustomBarcodeScannerView extends ConsumerStatefulWidget {
  const CustomBarcodeScannerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CustomBarcodeScannerViewState();
  }

}

class _CustomBarcodeScannerViewState extends ConsumerState<CustomBarcodeScannerView> {

  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;
  var _barcode = "바코드가 발견되지 않았습니다";

  @override
  void dispose() {
    _canProcess = false;
    _barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      barcode: _barcode,
      title: 'Barcode Scanner',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
      onCameraShutterTapped: () {
        Navigator.pop(context, _barcode);
      },
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final barcodes = await _barcodeScanner.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      if (barcodes.length != 0 ) {
        _barcode = barcodes.last.displayValue ?? "바코드가 발견되지 않았습니다";
      }
      else {
        _barcode = "바코드가 발견되지 않았습니다";
      }

    } else {
      String text = 'Barcodes found: ${barcodes.length}\n\n';
      for (final barcode in barcodes) {
        text += 'Barcode: ${barcode.rawValue}\n\n';
      }
      _text = text;
      // TODO: set _customPaint to draw boundingRect on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}