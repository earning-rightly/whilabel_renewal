import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/domain/whiskypost_response.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_grid_widget/main_grid_cell_widget.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_grid_widget/main_grid_view_model.dart';

import '../../../../enums/pagin_enum.dart';
import 'sub_widgets/expaneded_whisky_post_image.dart';

class MainGridWidget extends ConsumerStatefulWidget {
  const MainGridWidget({super.key});

  @override
  ConsumerState<MainGridWidget> createState() => _MainGridWidgetState();
}

class _MainGridWidgetState extends ConsumerState<MainGridWidget> {
  final _viewModel = MainGridViewModel();

  @override
  void initState() {
    super.initState();
    ref
        .refresh(_viewModel.provider.notifier)
        .callWhiskyPostGridAPI(PagingType.init);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_viewModel.provider);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cellWidth = (width - (10 * 3)) / 2;

    return GridView.builder(
      itemCount: state.data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 1 / 1.25,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10
    ), itemBuilder: (context,index) {
      final data = state.data[index];
      if (index == state.data.length - 1) {
        ref
            .read(_viewModel.provider.notifier)
            .callWhiskyPostGridAPI(PagingType.paging);
      }
     final postData = ref
          .read(_viewModel.provider.notifier)
          .getDuplicateWhiskyCount(data.whiskyId);
      return MainGridCellWidget(
        currentIndex: index,
        width: cellWidth,
        height: cellWidth * 1.25,
        imageUrl: data.imageUrl,
        whiskyCount: postData.length,
        holderTapEvent: (index) {
          showDialog(
            context: context,
            builder: (context) => SafeArea(
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ui.ImageFilter.blur(
                      sigmaX: 6.0,
                      sigmaY: 6.0,
                    ),
                    child: Container(
                      height:height,
                      width: width,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 0,
                    left: 0,
                    child: ExpandedWhiskyPostImage(
                      useDots: true,
                      dotsAlignment: Alignment.bottomCenter,
                      dotsColorInactive: ColorsManager.gray500,
                      dotsColorActive: ColorsManager.white,
                      height: height * 0.6,
                      context: context,
                      images: [

                        for (WhiskyPostResponse whiskeyNameGroupedArchivingPost
                        in postData)
                          whiskeyNameGroupedArchivingPost.imageUrl,
                      ],
                      onClick: (index) {
                        // final MockArchivingPost currentArchivingPost =
                        // whiskeyNameGroupedArchivingPosts[index];

                        // contextMenuViewModel.showContextMenu(
                        //     context,
                        //     overlay!.paintBounds.size.width,
                        //     overlay.paintBounds.size.height * 0.65);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );

        },
      );
    },);
  }
}
