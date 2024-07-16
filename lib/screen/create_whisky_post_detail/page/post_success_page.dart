import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/common_views/back_listener.dart';
import 'package:whilabel_renewal/screen/main_bottom_tab_page/main_bottom_tab_page.dart';
import 'package:whilabel_renewal/screen/util_views/show_dialog.dart';

class PostSuccessPage extends StatelessWidget {
  final int currentWhiskyCount;

  const PostSuccessPage({Key? key, required this.currentWhiskyCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackListener(
      onBackButtonClick: () {
        showMoveRootDialog(context);
      },
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height / 3.2,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: ColorsManager.brown100,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(SvgIconPath.checkBold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "${currentWhiskyCount + 1}번째 위스키에요!",
                    style: TextStylesManager.createHadColorTextStyle(
                        "M16", ColorsManager.brown100),
                  ),
                  SizedBox(height: 8),
                  Text("등록이 완료되었습니다", style: TextStylesManager.bold20),
                ],
              ),
            ),
            Positioned(
                bottom: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: ElevatedButton(
                              onPressed: () async {
                                /*TODO 공유하기 기능 넣기**/
                                // final lastArchivingPost  =  homeViewModel.state.listTypeArchivingPosts.first;
                                // await  WhilabelContextMenu.sharePostWhiskeyImage(lastArchivingPost.imageUrl);
                              },
                              child: Text(
                                "공유하기",
                                style: TextStylesManager.bold16,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: ColorsManager.brown100,
                                fixedSize: Size(120, 53),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                              )),
                        ),
                      ),
                      // 공유하기 기능을 만들면 추가
                      SizedBox(width: 12),
                      Expanded(
                          flex: 1,
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainBottomTabPage()),
                                    (Route<dynamic> route) => false);
                              },
                              child: Text(
                                "완료",
                                style: TextStylesManager.bold16,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: ColorsManager.brown100,
                                fixedSize: Size(120, 53),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
