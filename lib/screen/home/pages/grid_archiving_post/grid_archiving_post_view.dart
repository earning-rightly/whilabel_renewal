import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';

import './sub_widget/grid_archiving_card.dart';

class GridArchivingPostView extends ConsumerWidget {
  GridArchivingPostView({Key? key}) : super(key: key);

  final _provider = MockHomeViewModel().provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, List<MockArchivingPost>> gridTypeArchivingPosts =
        ref.watch(_provider).gridArchivingPosts;

    return GridView.builder(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      itemCount: gridTypeArchivingPosts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.25,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        // Map 형태인 gridTypeArchivingPosts의 key 값들을 순서대로 꺼내온다
        final whiskeyName = gridTypeArchivingPosts.keys.elementAt(index);

        return GridArchivingPostCard(
          whiskeyNameGroupedArchivingPosts:
              gridTypeArchivingPosts[whiskeyName]!,
        );
      },
    );
  }
}
