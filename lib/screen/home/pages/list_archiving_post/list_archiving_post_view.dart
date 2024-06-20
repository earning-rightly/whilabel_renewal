import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';
import 'package:whilabel_renewal/screen/home/pages/list_archiving_post/list_archiving_post_view_model.dart';

import 'sub_widget/list_archiving_card.dart';
import 'sub_widget/list_sorting_button.dart';

class ListArchivingPostView extends ConsumerWidget {
  final List<MockArchivingPost> posts;

  ListArchivingPostView({Key? key, required this.posts}) : super(key: key);

  final mockHomeProvider = MockHomeViewModel().provider;
  final provider = ListArchivingPostViewModel().provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final Size size = MediaQuery.of(context).size;
    Map<String, List<MockArchivingPost>> gridPosts =
        ref.watch(mockHomeProvider).gridArchivingPosts;
   final state = ref.watch(provider);
   final buttonStates = state.buttonStates;

    return Column(
      children: [
    Container(
      margin:  EdgeInsets.only(top: 12, bottom: 8),
      height: 32,
      width: size.width *1.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: buttonStates.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              ListSortingButton(
                listArchivingPostProvider: provider,
                  sortingButtonType:
                  buttonStates[index].buttonOrder,
                  index: index,
                  isSelected:  buttonStates[index].isSelected),
              SizedBox(width: 8),
            ],
          );
        }),
    ),

        // // 일정 공간에 띄어지게 하기위해서
        SizedBox(height: 16),

        Expanded(
            child: ListView.separated(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final currentArchivingPost = posts[index];

                  return ListArchivingPostCard(
                    archivingPost: currentArchivingPost,
                    sameWhiskyNameCounter:
                        gridPosts[currentArchivingPost.whiskyName]?.length ?? 0,
                  );
                },
                separatorBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height: 10),
                      Divider(
                        color: ColorsManager.black200,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  );
                }))
      ],
    );
  }
}
