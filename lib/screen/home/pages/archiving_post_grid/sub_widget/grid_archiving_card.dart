import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whilabel_renewal/data/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

import 'expanded_whiskey_image.dart';

// ignore: must_be_immutable
class GridArchivingPostCard extends StatelessWidget {
  final List<MockArchivingPost> whiskeyNameGroupedArchivingPosts;

  GridArchivingPostCard({
    Key? key,
    required this.whiskeyNameGroupedArchivingPosts,
  }) : super(key: key);

  GlobalKey key = GlobalKey(); // declare a global key

  @override
  Widget build(BuildContext context) {
    final Size size =  MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {

        showDialog(
          context: context,
          builder: (context) =>
              SafeArea(
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ui.ImageFilter.blur(
                        sigmaX: 6.0,
                        sigmaY: 6.0,
                      ),

                      child: Container(
                        height: size.height,
                        width: size.width,
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 0,
                      left: 0,
                      child: ExpandedWhiskeyImage(
                        useDots: true,
                        dotsAlignment: Alignment.bottomCenter,
                        dotsColorInactive: ColorsManager.gray500,
                        dotsColorActive: ColorsManager.gray200,
                        height: size.height * 0.6,
                        context: context,
                        images: [
                          for (MockArchivingPost whiskeyNameGroupedArchivingPost in whiskeyNameGroupedArchivingPosts)
                            whiskeyNameGroupedArchivingPost.imageUrl,
                        ],
                        onClick: (index) {
                          final MockArchivingPost currentArchivingPost = whiskeyNameGroupedArchivingPosts[index];


                        },
                      ),
                    ),
                  ],
                ),
              ),
        );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: SizedBox(
              width: 300,
              height: 375,
              child:  Image.network(
                filterQuality: FilterQuality.low,

                fit: BoxFit.fill,
                whiskeyNameGroupedArchivingPosts.first.imageUrl,
              ),
            ),
          ),
          Positioned(
              bottom: 12,
              right: 12,
              child: SizedBox(
                  child: Row(
                    children: [
                      SvgPicture.asset(SvgIconPath.whisky, width: 16,),
                      Text("${whiskeyNameGroupedArchivingPosts.length}",style: TextStylesManager.bold18,)
                    ],
                  )))

        ],
      ),
    );
  }
}