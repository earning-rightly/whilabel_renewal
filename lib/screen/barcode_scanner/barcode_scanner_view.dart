import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/barcode_scanner/barcode_scanner_view_model.dart';

import '../../design_guide_managers/svg_icon_path.dart';
import '../../design_guide_managers/text_style_manager.dart';

class BarcodeScannerView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(barcodeScannerViewModelProvider);

    return Scaffold(
      appBar: _scaffoldAppBar(context),
      body: Stack(

        children: [
          Positioned(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                color: Color.fromARGB(158, 6, 5, 6),
              ),
            ),
          ),

          TextButton(
              onPressed: () {
                ref
                    .read(barcodeScannerViewModelProvider.notifier)
                    .startBarcodeStream(context);
              },
              child: Text('Start barcode scan stream')
          ),
          Text(state.barcodeResult),
        ],
      ),
    );
  }

  AppBar _scaffoldAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 50,
      centerTitle: true,
      backgroundColor: ColorsManager.black100,
      leading: IconButton(
        padding: const EdgeInsets.only(left: 16),
        alignment: Alignment.centerLeft,
        icon: SvgPicture.asset(SvgIconPath.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        "탈퇴하기",
        style: TextStylesManager.bold16,
      ),
    );
  }
}
