import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_barcode_scanner_state.freezed.dart';

@freezed
class CustomBarcodeScannerState with _$CustomBarcodeScannerState {
  const factory CustomBarcodeScannerState({
    required bool isDetected,
    required String? barCodeResult
  }) = _CustomBarcodeScannerState;


  factory CustomBarcodeScannerState.initial() {
    return CustomBarcodeScannerState(isDetected: false, barCodeResult: null);
  }
}