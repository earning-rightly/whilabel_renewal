import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';

import 'my_page_view_model.dart';
import 'pages/setting_view/setting_view.dart';
import 'sub_widget/list_tittle_button.dart';

class MyPageView extends ConsumerWidget {
  MyPageView({Key? key}) : super(key: key);

  final provider = MyPageViewModel().provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Column(children: [
                // 마이페이지 최상상단 부분 (닉네임과 설정 아이콘)
                SizedBox(
                  width: size.width,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.7,
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "000님",
                                  style: TextStylesManager.bold24,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                //TODO nickname 수정 view로 이동
                                // 유저정보 수정하는 view로 이동
                                icon: SvgPicture.asset(SvgIconPath.modify),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                        Align(
                          child: IconButton(
                            icon: SvgPicture.asset(state.settingIconPath),
                            onPressed: () {
                              //TODO setting Page로 이동
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingView()));
                            },
                          ),
                        )
                      ]),
                ),
                // 마이페이지 리스트 중에 설정과 공지사항으로 이동 시켜주는 리스트 버튼
                for (Map<String, dynamic> data in state.myPageViewButtonData)
                  ListTitleIconButton(
                    svgPath: data["svg_path"],
                    titleText: data["title"],
                    pageRoute: data["route"],
                  ),

                const SizedBox(height: 16),
                // 마이페이지 설정과 문서보기를 구분 지어주는 선
                const Divider(
                  color: ColorsManager.black200,
                  thickness: 2,
                ),
                const SizedBox(height: 16),

                // 마이페이지 문서보기 리스트 버튼
                for (Map<String, dynamic> docData
                    in state.myPageViewDucButtonData)
                  ListTitleIconButton(
                    svgPath: docData["svg_path"],
                    titleText: docData["title"],
                    pageRoute: docData["route"],
                  ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(children: [
                      Text("버전 정보 1.0.0",
                          style: TextStylesManager.regular12Black400)
                    ]))
              ]))),
    );
  }
}
