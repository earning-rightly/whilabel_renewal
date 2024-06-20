// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/home/mock_home_view_model.dart';

import 'pages/archiving_post_grid/archiving_post_grid.dart';
import 'pages/archiving_post_list/archiving_post_list.dart';

class HomeView extends ConsumerWidget {
  HomeView({Key? key}) : super(key: key);

  bool isHasAnnouncement = false;

  final _provider = MockHomeViewModel().provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MockArchivingPost> posts = ref.watch(_provider).listArchivingPosts;
    final postCnt = posts.length;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: SizedBox(
            height: size.height * 1.5,
            width: size.width,
            child: Column(children: [
              buildAppBar(size, postCnt),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: ColorsManager.black300, width: 1))),
                child: TabBar(
                  indicatorColor: ColorsManager.gray500,
                  labelColor: ColorsManager.gray500,
                  unselectedLabelColor: ColorsManager.gray,
                  tabs: [
                    Tab(icon: SvgPicture.asset(SvgIconPath.list)),
                    Tab(icon: SvgPicture.asset(SvgIconPath.grid)),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TabBarView(children: [
                        ArchivingPostListView(
                          posts: posts,
                        ),
                        ArchivingPostGridView()
                      ])))
            ]),
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(Size size, int whiskeyCounter) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: size.width,
      height: 64,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          const Text(
            "나의 위스키",
            style: TextStylesManager.bold24,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                '$whiskeyCounter',
                style: TextStylesManager.createHadColorTextStyle(
                    "M20", ColorsManager.brown100),
              ))
        ]),
        IconButton(
            splashColor: ColorsManager.black300,
            splashRadius: 15,
            color: ColorsManager.gray200,
            padding: EdgeInsets.zero,
            icon: SvgPicture.asset(isHasAnnouncement
                ? SvgIconPath.notificationNew
                : SvgIconPath.notification),
            constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
            style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                iconSize: 24),
            onPressed: () {})
      ]),
    );
  }
}
