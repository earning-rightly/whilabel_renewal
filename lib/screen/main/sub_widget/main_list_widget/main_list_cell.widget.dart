import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../design_guide_managers/color_manager.dart';
import '../../../../design_guide_managers/text_style_manager.dart';

class MainListCellWidget extends StatelessWidget {
  final int currentIndex;
  final String imageUrl;
  final String whiskyname;
  final String address;
  final double distilleryRating;
  final String tasteNote;
  final double whiskyStarRate;
  final String createdAt;
  final int postCount;

  final Function(int) holderTapEvent;
  final Function(int) moreBtnTapEvent;

  const MainListCellWidget(
      {super.key,
      required this.currentIndex,
      required this.imageUrl,
      required this.whiskyname,
      required this.address,
      required this.distilleryRating,
      required this.tasteNote,
      required this.whiskyStarRate,
      required this.createdAt,
      required this.postCount,
      required this.holderTapEvent,
      required this.moreBtnTapEvent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        holderTapEvent(currentIndex);
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.5, color: ColorsManager.black200),
          ),
        ),
        height: 180,
        child: Row(
          children: [
            Container(
              width: 90,
              height: 120,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                margin:
                    EdgeInsets.only(left: 16, right: 0, bottom: 20, top: 23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            whiskyname,
                            style: TextStylesManager.bold16,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        ),
                        // 누르면 item meun 보여주는 아이콘 버튼
                        IconButton(
                            splashColor: ColorsManager.black300,
                            splashRadius: 15,
                            icon: Icon(Icons.more_horiz_outlined),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                                minWidth: 10, minHeight: 10),
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () async {
                              moreBtnTapEvent(currentIndex);
                            }),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "$address\t\u2022\t${distilleryRating.toString()}%",
                      style: TextStylesManager.createHadColorTextStyle(
                          "R12", ColorsManager.gray),
                    ),
                    const SizedBox(height: 6),
                    Flexible(
                      fit: FlexFit.tight, // 나머지 모든 공간을 차지
                      child: Container(
                        padding: EdgeInsets.only(left: 1, right: 1),
                        child: SizedBox(
                          child: Text(
                            tasteNote,
                            style: TextStylesManager.createHadColorTextStyle(
                                "R14", ColorsManager.gray300),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      height: 30,
                      width: 175,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: ColorsManager.black200),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.star,
                              color: ColorsManager.yellow, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "${whiskyStarRate}",
                            style: TextStylesManager.createHadColorTextStyle(
                                "M12", ColorsManager.yellow),
                          ),
                          Text(
                            "\t${createdAt}\t\u2022\t${postCount}잔",
                            style: TextStylesManager.createHadColorTextStyle(
                                "M12", ColorsManager.gray),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
