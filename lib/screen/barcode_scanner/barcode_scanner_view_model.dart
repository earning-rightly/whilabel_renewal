



import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/barcode_scanner/barcode_scanner_state.dart';

final barcodeScannerViewModelProvider = StateNotifierProvider<BarcodeScannerViewModel,BarcodeScannerState>( (ref) {
  return BarcodeScannerViewModel(ref);
});

class BarcodeScannerViewModel extends StateNotifier<BarcodeScannerState> { 
  final Ref ref;
  late final Timer _scanTimer;

  BarcodeScannerViewModel(this.ref) : super (BarcodeScannerState.initital());
  
  void startBarcodeStream(BuildContext context)  {
    String? result;
    _scanTimer = Timer.periodic(Duration(milliseconds: 500), (timer) async {
      try {
        if (result != "-1" || result != null) {
          timer.cancel();
        }
         result = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.BARCODE);
        state = state.copyWith(barcodeResult: result ?? "1234");
      }
      on PlatformException {
        print("몰라요 몰라");
      }
    });
  }
}