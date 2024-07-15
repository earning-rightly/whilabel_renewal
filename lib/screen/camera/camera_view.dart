import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/image_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/camera/camera_view_model.dart';
import 'package:whilabel_renewal/screen/camera/photo_taking/photo_taking_view.dart';
import 'package:whilabel_renewal/screen/common_views/long_text_button.dart';

class CameraView extends ConsumerWidget {
  CameraView({Key? key}) : super(key: key);

  final _viewModel = CameraViewModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final viewModel = ref.watch(_viewModel.provider.notifier);
    final viewTexts = ref.watch(_viewModel.provider).texts;
    viewModel.setBuildContext(context);

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 32),
              child: Text(
                viewTexts.pageTitle,
                style: TextStylesManager.bold24,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
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
                                viewModel.showBarcodeScanView();
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
