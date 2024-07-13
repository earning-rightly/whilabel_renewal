import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/domain/whiskypost_response.dart';

import 'main_grid_view_model.dart';

class MainGridCellWidget extends ConsumerWidget {
  final int currentIndex;
  final double width;
  final double height;
  final int whiskyCount;
  final String coverImage;

  final Function(int) holderTapEvent;

  MainGridCellWidget({
    required this.currentIndex,
    required this.width,
    required this.height,
    required this.whiskyCount,
    required this.holderTapEvent,
    required this.coverImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mainGridViewModel = MainGridViewModel();

    return GestureDetector(
      onTap: () {
        holderTapEvent(currentIndex);
      },
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              imageUrl: coverImage,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 12, bottom: 12),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: SvgPicture.asset(SvgIconPath.whisky,
                      color: ColorsManager.white, fit: BoxFit.fitWidth),
                ),
                const SizedBox(width: 1),
                Text(
                  "${whiskyCount}",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
