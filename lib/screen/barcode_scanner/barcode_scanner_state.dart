


import 'package:freezed_annotation/freezed_annotation.dart';

part 'barcode_scanner_state.freezed.dart';
@freezed
class BarcodeScannerState with _$BarcodeScannerState{
  const factory BarcodeScannerState({
    required String barcodeResult
}) = _BarcodeScannerState;

  factory BarcodeScannerState.initital() {
    return BarcodeScannerState(barcodeResult: "");
  }

}