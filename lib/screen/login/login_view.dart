

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whilabel_renewal/design_guide_managers/color_manager.dart';
import 'package:whilabel_renewal/design_guide_managers/svg_icon_path.dart';
import 'package:whilabel_renewal/design_guide_managers/text_style_manager.dart';
import 'package:whilabel_renewal/screen/login/login_view_model.dart';
import 'package:whilabel_renewal/screen/login/sub_widget/sns_login_btn.dart';

class LoginView extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(loginViewModelProvider);

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
                Text(state.texts.logoText, style: TextStylesManager.createHadColorTextStyle("B16", ColorsManager.white)),
                const Spacer(flex: 1),

                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,bottom: 32),
                  child: Column(
                    children: [
                      SNSLoginBtn(onPressed: () {

                      }, iconPath: SvgIconPath.instargramIcon,
                          title: state.texts.instagramBtnTitle),
                      const SizedBox(height: 16),
                      SNSLoginBtn(onPressed: () {

                      }, iconPath: SvgIconPath.googleIcon,
                          title: state.texts.googleBtnTitle),
                      const SizedBox(height: 16),
                      SNSLoginBtn(onPressed: () {

                      }, iconPath: SvgIconPath.appleIcon,
                          title: state.texts.appleBtnTitle),
                      const SizedBox(height: 16),
                      SNSLoginBtn(onPressed: () {

                      }, iconPath: SvgIconPath.kakaoIcon,
                          title: state.texts.kakaoBtnTitle),
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