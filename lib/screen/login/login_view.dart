

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/login/sub_widget/sns_login_btn.dart';

class LoginView extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xffA87137),
                  Color(0xff864E33),
                ]
              )
            ),
            child: Column(
              children: [
                const Spacer(flex: 1),
                SvgPicture.asset(SvgIconPath.whilabelIcon , width: 200, fit: BoxFit.cover),
                const SizedBox(height: 16),
                Text("dkdkdkdkdkdk", style: TextStylesManager.createHadColorTextStyle("B16", ColorsManager.white)),
                const Spacer(flex: 1),

                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,bottom: 32),
                  child: Column(
                    children: [
                      SNSLoginBtn(onPressed: () {

                      }, iconPath: SvgIconPath.instargramIcon,
                          title: "인스타그램 계정으로 로그인"),
                      const SizedBox(height: 16),
                      SNSLoginBtn(onPressed: () {

                      }, iconPath: SvgIconPath.googleIcon,
                          title: "구글 계정으로 로그인"),
                      const SizedBox(height: 16),
                      SNSLoginBtn(onPressed: () {

                      }, iconPath: SvgIconPath.appleIcon,
                          title: "애플 계정으로 로그인"),
                      const SizedBox(height: 16),
                      SNSLoginBtn(onPressed: () {

                      }, iconPath: SvgIconPath.kakaoIcon,
                          title: "카카오톡 계정으로 로그인"),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}