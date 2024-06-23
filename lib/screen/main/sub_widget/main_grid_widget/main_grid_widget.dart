import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_grid_widget/main_grid_cell_widget.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_grid_widget/main_grid_view_model.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_list_widget/main_list_view_model.dart';

import '../../../../enums/pagin_enum.dart';

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
      return MainGridCellWidget(
        currentIndex: index,
        width: cellWidth,
        height: cellWidth * 1.25,
        imageUrl: data.imageUrl,
        whiskyCount: ref
            .read(_viewModel.provider.notifier)
            .getDuplicateWhiskyCount(data.whiskyId),
        holderTapEvent: (index) {},
      );
    },);
  }
}
