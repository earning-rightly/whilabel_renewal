import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/scan_main_page/_pages/image_preview_page.dart';
import 'package:whilabel_renewal/screen/scan_main_page/gallery/galler_view_model.dart';

import '../../../design_guide_managers/svg_icon_path.dart';
import '../../../design_guide_managers/text_style_manager.dart';

// ignore: must_be_immutable
class GalleryView extends ConsumerStatefulWidget {
  GalleryView(
      {super.key,
      this.onImageSelectedForBarcodeScan,
      this.onDetectorViewModeChanged,
      this.isInBarcodeScanMode = false});

  bool isInBarcodeScanMode;

  //used when in BarcodeScanMode
  final Function(InputImage inputImage)? onImageSelectedForBarcodeScan;
  final Function()? onDetectorViewModeChanged;

  @override
  ConsumerState<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends ConsumerState<GalleryView> {
  final _viewModel = GalleryViewModel();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.watch(_viewModel.provider.notifier).initProcess();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(_viewModel.provider.notifier).setBuildContext(context);
    final state = ref.watch(_viewModel.provider);
    // 로딩 처리 코드
    if (state.isLoading) {
      return const SafeArea(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: _scaffoldAppBar(context),
      backgroundColor: ColorsManager.black100,
      body: SafeArea(
        child: state.isLoading
            ? const Stack(
                children: [
                  Positioned(
                    child: CircularProgressIndicator(),
                  ),
                ],
              )
            : GridView.builder(
                shrinkWrap: true,
                itemCount: state.mediums.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //1 개의 행에 보여줄 item 개수
                  childAspectRatio: 1 / 1, //item 의 가로 1, 세로 1 의 비율
                  mainAxisSpacing: 4, //수평 Padding
                  crossAxisSpacing: 4, //수직 Padding
                ),
                itemBuilder: (BuildContext context, int index) {
                  Medium medium = state.mediums[index];
                  return GestureDetector(
                    onTap: () async {
                      if (widget.isInBarcodeScanMode) {

                      }
                      else {
                        ref
                            .read(_viewModel.provider.notifier)
                            .showImagePreviewPage(medium);
                      }
                    },
                    child: SizedBox(
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: MemoryImage(kTransparentImage),
                        image: ThumbnailProvider(
                          mediumId: medium.id,
                          mediumType: medium.mediumType,
                          highQuality: true,
                        ),
                      ),
                    ),
                  );
                },
              ),
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
        icon: SvgPicture.asset(SvgIconPath.backBold),
        onPressed: () {
          if (widget.isInBarcodeScanMode) {
            if (widget.onDetectorViewModeChanged != null) {
              widget.onDetectorViewModeChanged!();
            }
          }
          else {
            Navigator.pop(context);
          }
        },
      ),
      title: const Text(
        "앨범",
        style: TextStylesManager.bold16,
      ),
    );
  }


}
