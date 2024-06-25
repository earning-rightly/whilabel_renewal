import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/image_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/camera/barcode_scan/barcode_scan_view.dart';
import 'package:whilabel_renewal/screen/camera/camera_view_model.dart';
import 'package:whilabel_renewal/screen/camera/photo_taking/photo_taking_view.dart';
import 'package:whilabel_renewal/screen/common_views/long_text_button.dart';

class CameraView extends ConsumerWidget {
  CameraView({Key? key}) : super(key: key);

  final _provider = CameraViewModel().provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final barcode = ref.watch(_provider).barcode;
    final camera = ref.watch(_provider).cameras;

    final viewModel = ref.watch(_provider.notifier);
  

    return Scaffold(
        body: SafeArea(
            child: Padding(
      // padding: WhilabelPadding.onlyHoizBasicPadding,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () {
                 viewModel.initCamera();

                  // viewModel.updateBarCode(res);
                },
                child: Text("init state!!!")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoTakingView(cameras: camera),
                      ));

                  // viewModel.updateBarCode(res);
                },
                child: Text("taka a picture")),
            height * 0.8 <= width
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      "위스키 기록",
                      style: TextStylesManager.bold24,
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Text(
                        "위스키 기록",
                        style: TextStylesManager.bold24,
                      ),
                    ),
                  ),
            Expanded(
              flex: height * 0.8 <= width ? 1 : 3,
              child: SizedBox(
                child: Column(
                  children: [
                    Image.asset(
                      cameraViewPngImage,
                    ),
                    SizedBox(height: height * 0.85 <= width ? 0 : 32),
                    Text(
                      "오늘 마신 위스키를 기록해볼까요?",
                      style: TextStylesManager.bold20,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: height * 0.85 <= width ? 0 : 24),
                    Text(
                      "본격적인 위스키 생활을 시작해보세요",
                      style: TextStylesManager.createHadColorTextStyle(
                          "R16", ColorsManager.gray),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: height * 0.85 <= width ? 0 : 24),
                    Container(
                      width: width,
                      child: Row(
                        children: [
                          Expanded(flex: 5, child: SizedBox()),
                          Expanded(
                            flex: 40,
                            child: LongTextButton(
                              buttonText: "위스키 기록하기",
                              color: ColorsManager.brown100,
                              onPressedFunc: () async {
                                String res = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BarcodeScanView(),
                                    ));

                                viewModel.updateBarCode(res);
                              },
                            ),
                          ),
                          Expanded(flex: 5, child: SizedBox()),
                        ],
                      ),
                    ),
                    Text(
                      "BarCode : $barcode",
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ],
                ),
              ),
            ),
            height * 0.8 <= width ? SizedBox() : SizedBox(height: 20)
          ],
        ),
      ),
    )));
  }
}
