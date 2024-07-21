import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:whilabel_renewal/screen/scan_main_page/custom_barcode_scanner/sub_widget/detector_view.dart';

String _barcodeNotFoundMessage = "바코드가 발견되지 않았습니다";
int MAX_REPEATED_BARCODE_COUNT = 5;

class CustomBarcodeScannerView extends ConsumerStatefulWidget {
  const CustomBarcodeScannerView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CustomBarcodeScannerViewState();
  }
}

class _CustomBarcodeScannerViewState
    extends ConsumerState<CustomBarcodeScannerView> {
  final BarcodeScanner _barcodeScanner = BarcodeScanner();
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;
  var _barcode = _barcodeNotFoundMessage;
  int repeatedBarcodeCount = 0;
  String preBarcode = "";

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

      if (barcodes.length != 0 && barcodes.last.displayValue != null) {
        String? lastBarcode = barcodes.last.displayValue;

        if (lastBarcode != preBarcode &&
            lastBarcode != _barcodeNotFoundMessage) {
          _barcode = lastBarcode!;
          preBarcode = lastBarcode;
          repeatedBarcodeCount= 0;
        }

        if (lastBarcode == preBarcode) {
          repeatedBarcodeCount++;
        }
      }
      if (repeatedBarcodeCount >= MAX_REPEATED_BARCODE_COUNT) {
        _barcode = preBarcode;
      } else {
        _barcode = _barcodeNotFoundMessage;
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
