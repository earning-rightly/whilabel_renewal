import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';

import 'sub_widget/list_archiving_card.dart';

class ArchivingPostListView extends ConsumerWidget {
  final List<MockArchivingPost> posts;

  ArchivingPostListView({Key? key, required this.posts}) : super(key: key);

  final _provider = MockHomeViewModel().provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, List<MockArchivingPost>> gridPosts =
        ref.watch(_provider).gridArchivingPosts;

    return Column(
      children: [
        // 리스트에서 사용할 위스키 정렬 버튼
        Container(height: 32, child: Text("리스트 위스키")),

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
