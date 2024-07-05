import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_grid_widget/main_grid_cell_widget.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_grid_widget/main_grid_view_model.dart';
import 'package:whilabel_renewal/screen/util_views/context_menu/context_menu_view_model.dart';

import '../../../../enums/pagin_enum.dart';

class MainGridWidget extends ConsumerStatefulWidget {
  const MainGridWidget({super.key});

  @override
  ConsumerState<MainGridWidget> createState() => _MainGridWidgetState();
}

class _MainGridWidgetState extends ConsumerState<MainGridWidget> {
  final _viewModel = MainGridViewModel();
  final _contextMenuProvider = ContextMenuViewModel().provider;

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

    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();

    return GridView.builder(
      itemCount: state.data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.25,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10),
      itemBuilder: (context, index) {
        final data = state.data[index];
        if (index == state.data.length - 1) {
          ref
              .read(_viewModel.provider.notifier)
              .callWhiskyPostGridAPI(PagingType.paging);
        }
        final groupingIdPosts = ref
            .read(_viewModel.provider.notifier)
            .getDuplicateWhiskys(data.whiskyId);
        return MainGridCellWidget(
          posts: groupingIdPosts,
          currentIndex: index,
          coverImage: groupingIdPosts.first.imageUrl,
          width: cellWidth,
          height: cellWidth * 1.25,
          whiskyCount: groupingIdPosts.length,
          holderTapEvent: (index) {
            ref.read(_viewModel.provider.notifier).showExpendingImage(context,
                posts: groupingIdPosts, onTapExpandedImageEvent: (index) {
              ref.read(_contextMenuProvider.notifier).showContextMenu(
                  context,
                  overlay!.paintBounds.size.width,
                  overlay.paintBounds.size.height * 0.65);
            }, height: height, width: width);
          },

        );
      },
    );
  }
}
