import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/enums/pagin_enum.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_list_widget/main_list_cell.widget.dart';
import 'package:whilabel_renewal/screen/main/sub_widget/main_list_widget/main_list_view_model.dart';

import '../../../../design_guide_managers/color_manager.dart';
import '../../../../design_guide_managers/text_style_manager.dart';

class MainListWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState<MainListWidget> createState() => _MainListWidgetState();
}

class _MainListWidgetState extends ConsumerState<MainListWidget> {
  final MainListViewModel viewModel = MainListViewModel();

  @override
  void initState() {
    super.initState();
    ref
        .refresh(viewModel.provider.notifier)
        .callWhiskyPostListAPI(PagingType.init);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(viewModel.provider);
    ref.read(viewModel.provider.notifier).setBuildContext(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 16, bottom: 16),
          height: 32,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _sortBtn(context, "최신순", "recent"),
              const SizedBox(width: 8),
              _sortBtn(context, "오래된 순", "oldest"),
              const SizedBox(width: 8),
              _sortBtn(context, "평점 높은 순", "rating-ascend"),
              const SizedBox(width: 8),
              _sortBtn(context, "평점 낮은 순", "rating-descend"),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final data = state.data[index];
                if (index == state.data.length - 1) {
                  ref
                      .read(viewModel.provider.notifier)
                      .callWhiskyPostListAPI(PagingType.paging);
                }

                return MainListCellWidget(
                  currentIndex: index,
                  imageUrl: data.imageUrl,
                  whiskyname: data.name,
                  address: data.address,
                  distilleryRating: data.distilleryRating,
                  tasteNote: data.tasteNote,
                  whiskyStarRate: data.rating,
                  createdAt: ref
                      .read(viewModel.provider.notifier)
                      .formatDate(data.modifyDateTime ?? data.createDateTime),
                  postCount: ref
                      .read(viewModel.provider.notifier)
                      .getDuplicateWhiskyCount(data.whiskyId),
                  holderTapEvent: (currentIndex) {
                    ref.read(viewModel.provider.notifier).showWhiskyPostDetailView(data.id);
                  },
                  moreBtnTapEvent: (currentIndex) {},
                );
              }),
        ),
      ],
    );
  }

  Widget _sortBtn(BuildContext context, String title, String sortKey) {
    final state = ref.watch(viewModel.provider);

    return OutlinedButton(
      onPressed: () {
        ref.watch(viewModel.provider.notifier).sortChanged(sortKey);
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: state.currentSortType == sortKey
            ? ColorsManager.black300
            : Colors.transparent,
        backgroundColor: state.currentSortType == sortKey
            ? ColorsManager.black300
            : Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 8),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: state.currentSortType == sortKey
                ? const BorderSide(color: Colors.transparent)
                : const BorderSide(color: ColorsManager.black300)),
      ),
      child: Text(title,
          maxLines: 1,
          style: state.currentSortType == sortKey
              ? TextStylesManager.createHadColorTextStyle(
                  "M14", ColorsManager.gray300)
              : TextStylesManager.createHadColorTextStyle(
                  "M14", ColorsManager.black300)),
    );
  }
}
