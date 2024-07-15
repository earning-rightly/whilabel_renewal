import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom_barcode_scanner_state.dart';


class CustomBarcodeScannerViewModel extends StateNotifier<CustomBarcodeScannerState> {
  final Ref ref;


  final provider = StateNotifierProvider<CustomBarcodeScannerViewModel, CustomBarcodeScannerState>( (ref) {
    return CustomBarcodeScannerViewModel(ref);
  });


  CustomBarcodeScannerViewModel(this.ref) : super(CustomBarcodeScannerState.initial());




}