import 'package:flutter/material.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/mock_data/archiving_post/mock_archiving_post.dart';
import 'package:whilabel_renewal/screen/whiskey_detail/archivng_post_detail_view.dart';

// ignore: must_be_immutable
class MockPost extends StatelessWidget {
  final MockArchivingPost archivingPost;

  MockPost({
    Key? key,
    required this.archivingPost,
  }) : super(key: key);
  String creatDate = "";
  GlobalKey key = GlobalKey(); // declare a global key

  void initState() {}

  @override
  Widget build(BuildContext context) {
    // final homeViewModel = context.watch<HomeViewModel>();
    // final DateTime date1 = DateTime.fromMicrosecondsSinceEpoch(
    //     archivingPost.createAt!.microsecondsSinceEpoch);

    // creatDate = DateFormat("yyyy.MM.dd").format(date1);
    creatDate ="11111";

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArchivingPostDetailView()));

      },
      child: Container(
        width: 350,
        height: 110,
        color: Colors.transparent,
        child: Row(
          children: [
            // 리스트 왼쪽 위스키 사진
            Expanded(
              flex: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  width: 85,
                  height: 120,
                  child: Image.network(
                    filterQuality: FilterQuality.low,
                    archivingPost.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // SizedBox(width: .space16),
            // 사진을 제외한 모든 공간
            Expanded(
              flex: 247,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // whisky이름이 12자 이상이면 그 뒤로는 ... 표시
                        // archivingPost.whiskyName.length > 12
                        //     ? archivingPost.whiskyName.substring(0, 12)
                        //     : "${archivingPost.whiskyName}...",

                        archivingPost.whiskyName.length < 12
                            ? archivingPost.whiskyName
                            : "${archivingPost.whiskyName.substring(0, 12)}...",
                        style: TextStylesManager.bold16,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // 누르면 item meun 보여주는 아이콘 버튼
                      IconButton(
                        splashColor: ColorsManager.black300,
                        splashRadius: 15,
                        icon: Icon(Icons.more_horiz_outlined),
                        padding: EdgeInsets.zero,
                        constraints:
                        const BoxConstraints(minWidth: 10, minHeight: 10),
                        style: IconButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () async {
                          }

                      )
                    ],
                  ),
                  SizedBox(height: 6),

                  Text(
                    "${archivingPost.location ?? ""}\t\u2022\t${archivingPost.strength ?? 0.0.toString()}%",
                    style: TextStylesManager.createHadColorTextStyle(
                        "R12", ColorsManager.gray),
                  ),
                  SizedBox(height:6),
                  Flexible(
                    fit: FlexFit.tight, // 나머지 모든 공간을 차지
                    child: Container(
                      padding: EdgeInsets.only(left: 1, right: 1),
                      child: SizedBox(
                        child: Text(
                          archivingPost.note.length < 24
                              ? archivingPost.note
                              : "${archivingPost.note.substring(0, 24)}...",
                          style: TextStylesManager.createHadColorTextStyle(
                              "R14", ColorsManager.gray300),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    height: 30,
                    width:175,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: ColorsManager.black200),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star, color: ColorsManager.yellow, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "${archivingPost.starValue}",
                          style: TextStylesManager.createHadColorTextStyle(
                              "M12", ColorsManager.yellow),
                        ),
                        Text(
                          "\t$creatDate",
                          style: TextStylesManager.createHadColorTextStyle(
                              "M12", ColorsManager.gray),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}