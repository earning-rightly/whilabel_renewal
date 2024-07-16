import 'package:camera/camera.dart';
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

  Future<List<CameraDescription>> getCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final _camera = await availableCameras();

    return _camera;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final viewModel = ref.watch(cameraProvider.notifier);
    final viewTexts = ref.watch(cameraProvider).texts;

    return Scaffold(
        body: SafeArea(
            child: Padding(
      // padding: WhilabelPadding.onlyHoizBasicPadding,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height * 0.8 <= width
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 32),
                    child: Text(
                      viewTexts.pageTitle,
                      style: TextStylesManager.bold24,
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: Text(
                        viewTexts.pageTitle,
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
                      viewTexts.pageIntroduce,
                      style: TextStylesManager.bold20,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: height * 0.85 <= width ? 0 : 24),
                    Text(
                      viewTexts.cameraSlogan,
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
                              buttonText: viewTexts.longTextButtonTitle,
                              color: ColorsManager.brown100,
                              onPressedFunc: () async {
                                final cameras = await getCamera();

                                String barcode = "";

                                barcode = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BarcodeScanView(),
                                    ));
                                final isRecognition =
                                    await viewModel.updateBarCode(barcode);

                                if (isRecognition == false) {
                                  await viewModel.showBarcodeNoMatchDialog(
                                      context, cameras);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return PhotoTakingView(
                                          cameras: cameras);
                                    }),
                                  );
                                }
                              },
                            ),
                          ),
                          Expanded(flex: 5, child: SizedBox()),
                        ],
                      ),
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
