import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/custom_barcode_scanner/custom_barcode_scanner_state.dart';

final customBarcodeScannerViewModelProvider = StateNotifierProvider<CustomBarcodeScannerViewModel, CustomBarcodeScannerState>( (ref) {
  return CustomBarcodeScannerViewModel(ref);
});

class CustomBarcodeScannerViewModel extends StateNotifier<CustomBarcodeScannerState> {
  final Ref ref;

  CustomBarcodeScannerViewModel(this.ref) : super(CustomBarcodeScannerState.initial());


}