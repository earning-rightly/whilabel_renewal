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
    final gridPostData = state.data;
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
        List<int> groupingPostIndexes = ref
            .read(_viewModel.provider.notifier)
            .getWhiskyIdToDataIndexes(data.whiskyId);
        print("groupingPostIndexes: ${groupingPostIndexes}\t index:$index");
        return MainGridCellWidget(
          currentIndex: index,
          coverImage: state.data[index].imageUrl,
          width: cellWidth,
          height: cellWidth * 1.25,
          whiskyCount: groupingPostIndexes.length,
          holderTapEvent: (index) {
            groupingPostIndexes.remove(index);
            groupingPostIndexes.insert(0, index);

            ref.read(_viewModel.provider.notifier).showExpendingImage(context,
                posts: gridPostData
                    .where((post) => groupingPostIndexes
                        .contains(gridPostData.indexOf(post)))
                    .toList(),
             onTapExpandedImageEvent: (index) {
              print(groupingPostIndexes);

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
